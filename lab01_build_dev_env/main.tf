
# This terraform template deploys a VPC with one public subnet, internet gateway, route table, a security group, and one EC2 instance.

resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc-dev"
  }
}

resource "aws_subnet" "tf-public-subnet-1" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tf-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tf-igw-1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-igw-1"
  }
}

resource "aws_route_table" "tf-rt-table" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "tf-rt-1-public"
  }
}

resource "aws_route" "tf-rt-route" {
  route_table_id         = aws_route_table.tf-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw-1.id
}

resource "aws_route_table_association" "tf-rt-assoc-1" {
  subnet_id      = aws_subnet.tf-public-subnet-1.id
  route_table_id = aws_route_table.tf-rt-table.id
}

resource "aws_security_group" "tf-sg-1" {
  name        = "tf-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["1.2.3.4/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-1"
  }
}

resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}

resource "aws_instance" "tf-node-1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.tf-ami.id
  key_name               = aws_key_pair.tf-keypair.id
  vpc_security_group_ids = [aws_security_group.tf-sg-1.id]
  subnet_id              = aws_subnet.tf-public-subnet-1.id
  user_data              = file("userdata.tpl")

  provisioner "local-exec" {
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/tf-keypair"
    })
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tf-node-1"
  }
}