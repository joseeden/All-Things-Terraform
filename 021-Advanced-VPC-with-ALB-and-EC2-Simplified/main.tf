# lab05_Advanced_VPC_ALB_EC2_Simplified
#---------------------------------------------------------------------
# Refactored the main.tf for lab04 by using count_meta for 
# subnets and route tables
#---------------------------------------------------------------------

resource "aws_vpc" "lab04-vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lab04-vpc"
  }
}

# Creates the public subnet 1 and 2
resource "aws_subnet" "lab04-public-subnet" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.lab04-vpc.id
  count                   = length(var.avail_zones)
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(var.avail_zones, count.index)

  tags = {
    Name = "lab04-public-subnet-${element(var.avail_zones, count.index)}"
    Type = "Public"
  }
}

# Creates the private subnet 1 and 2
resource "aws_subnet" "lab04-private-subnet" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.lab04-vpc.id
  count                   = length(var.avail_zones)
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + length(var.avail_zones))
  availability_zone       = element(var.avail_zones, count.index)

  tags = {
    Name = "lab04-private-subnet-${element(var.avail_zones, count.index)}"
    Type = "Public"
  }
}

resource "aws_internet_gateway" "lab04-igw" {
  vpc_id = aws_vpc.lab04-vpc.id

  tags = {
    Name = "lab04-igw"
  }
}

# Create the Elastic IPs per availability zone
resource "aws_eip" "lab04-eip-nat" {
  count = length(var.avail_zones)
  vpc   = true
}

# Creates the NAT gateway - Public NAT.
# This creates a NAT gateway in each availability zone.
resource "aws_nat_gateway" "lab04-natgw" {
  count         = length(var.avail_zones)
  allocation_id = element(aws_eip.lab04-eip-nat.*.id, count.index)
  subnet_id     = element(aws_subnet.lab04-public-subnet.*.id, count.index)

  tags = {
    Name = "lab04-natgw-${element(var.avail_zones, count.index)}"
  }

  # To ensure proper ordering, it is recommended to add an 
  # explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lab04-igw]
}

#========================================================================
# Creates the route table. One route table per AZ
# This is a public route table that routes to the IGW.
resource "aws_route_table" "lab04-rt-public" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab04-igw.id
  }

  tags = {
    Name = "lab04-rt-public"
  }
}

# Associates the route table to the public subnet
resource "aws_route_table_association" "lab04-route-assoc-public" {
  count          = length(var.avail_zones)
  subnet_id      = element(aws_subnet.lab04-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.lab04-rt-public.id
}

#========================================================================
# This is a private route table that routes to the NAT-GW.
resource "aws_route_table" "lab04-rt-private" {
  vpc_id = aws_vpc.lab04-vpc.id
  count  = length(var.avail_zones)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.lab04-natgw.*.id, count.index)
  }

  tags = {
    Name = "lab04-rt-private-${element(var.avail_zones, count.index)}"
  }
}

# Associates the route table to the subnets
resource "aws_route_table_association" "lab04-route-assoc-private" {
  count          = length(var.avail_zones)
  subnet_id      = element(aws_subnet.lab04-private-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.lab04-rt-private.*.id, count.index)
}
#========================================================================

# Creates the security group for the autoscaling group of wenservers
# Note that the egress traffic is routed to the ALB.
# This can be seen on the cidr_blocks of the second ingress.
resource "aws_security_group" "lab04-secgroup-1" {
  name        = "lab04-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere, through the ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      cidrsubnet(var.cidr_block, 8, 1),
      cidrsubnet(var.cidr_block, 8, 2)
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Creates the security group for the ALB
# This allows inbound traffic from the internet and
# allows outbound traffic to go through only the webserber security group
resource "aws_security_group" "lab04-secgroup-2" {
  name        = "lab04-secgroup-2"
  description = "Allow ALB network traffic"
  vpc_id      = aws_vpc.lab04-vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lab04-secgroup-1.id]
  }

  tags = {
    Name = "lab04-secgroup-1"
  }
}

# Launch template for the autoscaling group
# The "webserver.tpl" bootstraps the instances in the ASG wIth NGINX.
# This uses string interpolation to inject the current module path.
resource "aws_launch_template" "lab04-launchtemplate-webserver" {
  name = "lab04-launchtemplate-webserver"

  image_id               = data.aws_ami.lab04_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.lab04-keypair.id
  vpc_security_group_ids = [aws_security_group.lab04-secgroup-1.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lab04-webserver"
    }
  }
  user_data = filebase64("${path.module}/webserver.tpl")
}

# Creates the external-facing ALB.
resource "aws_lb" "lab04-alb" {
  name                       = "lab04-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lab04-secgroup-2.id]
  enable_deletion_protection = false
  subnets                    = aws_subnet.lab04-public-subnet.*.id

  tags = {
    Environment = "PRD"
  }
}

resource "aws_lb_target_group" "lab04-alb-target-group" {
  name     = "lab04-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab04-vpc.id
}

resource "aws_lb_listener" "lab04-alb-front_end" {
  load_balancer_arn = aws_lb.lab04-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }
}

# Forwards the route path to the target group
resource "aws_lb_listener_rule" "lab04-alb-listener-rule-1" {
  listener_arn = aws_lb_listener.lab04-alb-front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab04-alb-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

# Creates the ASG of webserver instances.
resource "aws_autoscaling_group" "lab04-asg" {
  name                = "lab04-asg"
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = aws_subnet.lab04-private-subnet.*.id

  target_group_arns = [
    aws_lb_target_group.lab04-alb-target-group.arn
  ]

  launch_template {
    id      = aws_launch_template.lab04-launchtemplate-webserver.id
    version = "$Latest"
  }
}

# Imports the keypair
resource "aws_key_pair" "lab04-keypair" {
  key_name   = "lab04-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}