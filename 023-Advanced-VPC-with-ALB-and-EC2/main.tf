# lab04_Advanced_VPC_ALB_EC2
#---------------------------------------------------------------------
# This terraform template deploys a VPC with 2 public subnets that has 
# a security group, an internet gateway, a NAT gateway, and an 
# Application loadbalancer. Traffic will be loadbalanced between the 
# EC2 instances in the autoscaling group. Finally, the instances are 
# bootstrapped with an NGINX webserver.
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

# Creates the first public subnet.
resource "aws_subnet" "lab04-public-subnet-1" {
  vpc_id     = aws_vpc.lab04-vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
  # map_public_ip_on_launch = true
  availability_zone = var.avail_zones[0]

  tags = {
    Name = "lab04-public-subnet-1"
    Type = "Public"
  }
}

# Creates the second public subnet.
resource "aws_subnet" "lab04-public-subnet-2" {
  vpc_id     = aws_vpc.lab04-vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 2)
  # map_public_ip_on_launch = true
  availability_zone = var.avail_zones[1]

  tags = {
    Name = "lab04-public-subnet-2"
    Type = "Public"
  }
}

# Creates the first private subnet.
resource "aws_subnet" "lab04-private-subnet-1" {
  vpc_id            = aws_vpc.lab04-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = var.avail_zones[0]

  tags = {
    Name = "lab04-private-subnet-1"
    Type = "Private"
  }
}

# Creates the second private subnet.
resource "aws_subnet" "lab04-private-subnet-2" {
  vpc_id            = aws_vpc.lab04-vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = var.avail_zones[1]

  tags = {
    Name = "lab04-private-subnet-2"
    Type = "Private"
  }
}

resource "aws_internet_gateway" "lab04-igw" {
  vpc_id = aws_vpc.lab04-vpc.id

  tags = {
    Name = "lab04-igw"
  }
}

# Create the Elastic IP to be used by the NAT gateway.
resource "aws_eip" "lab04-eip-nat" {
  vpc = true
}

# Creates the NAT gateway - Public NAT.
# The NAT gateway is provisioned in the first public subnet
resource "aws_nat_gateway" "lab04-natgw" {
  allocation_id = aws_eip.lab04-eip-nat.id
  subnet_id     = aws_subnet.lab04-public-subnet-1.id

  tags = {
    Name = "lab04-natgw"
  }

  # To ensure proper ordering, it is recommended to add an 
  # explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lab04-igw]
}

# Creates the route table. One route table per AZ
# This is a public route table that routes to the IGW.
resource "aws_route_table" "lab04-rt-public-1" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab04-igw.id
  }

  tags = {
    Name = "lab04-rt-public-1"
  }
}

# This is a private route table that routes to the NAT-GW.
resource "aws_route_table" "lab04-rt-private-2" {
  vpc_id = aws_vpc.lab04-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lab04-natgw.id
  }

  tags = {
    Name = "lab04-rt-private-2"
  }
}

# Associates the route table to the first public subnet
resource "aws_route_table_association" "lab04-route-assoc-1" {
  subnet_id      = aws_subnet.lab04-public-subnet-1.id
  route_table_id = aws_route_table.lab04-rt-public-1.id
}

# Associates the route table to the second public subnet
resource "aws_route_table_association" "lab04-route-assoc-2" {
  subnet_id      = aws_subnet.lab04-public-subnet-2.id
  route_table_id = aws_route_table.lab04-rt-public-1.id
}

# Associates the route table to the first private subnet
resource "aws_route_table_association" "lab04-route-assoc-3" {
  subnet_id      = aws_subnet.lab04-private-subnet-1.id
  route_table_id = aws_route_table.lab04-rt-private-2.id
}

# Associates the route table to the second private subnet
resource "aws_route_table_association" "lab04-route-assoc-4" {
  subnet_id      = aws_subnet.lab04-private-subnet-2.id
  route_table_id = aws_route_table.lab04-rt-private-2.id
}

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

  subnets = [
    aws_subnet.lab04-public-subnet-1.id,
    aws_subnet.lab04-public-subnet-2.id
  ]

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

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
  name             = "lab04-asg"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2

  target_group_arns = [
    aws_lb_target_group.lab04-alb-target-group.arn
  ]

  vpc_zone_identifier = [
    aws_subnet.lab04-private-subnet-1.id,
    aws_subnet.lab04-private-subnet-2.id
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