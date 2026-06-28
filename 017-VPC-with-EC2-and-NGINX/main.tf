# lab03_VPC_with_EC2_Nginx
#--------------------------------------------------------------
# This terraform template deploys a VPC with 2 public subnets
# that has a security group, an internet gateway, and a 
# single route table. 
# An EC2 is also created with Nginx installe.
#--------------------------------------------------------------

# Creates the VPC.
resource "aws_vpc" "lab03-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lab03-vpc"
  }
}

# Creates the first public subnet.
resource "aws_subnet" "lab03-public-1" {
  vpc_id                  = aws_vpc.lab03-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.avail_zones[0]

  tags = {
    Name = "lab03-public-1"
    Type = "Public"
  }
}

# Creates the second public subnet.
resource "aws_subnet" "lab03-public-2" {
  vpc_id                  = aws_vpc.lab03-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.avail_zones[1]

  tags = {
    Name = "lab03-public-2"
    Type = "Public"
  }
}

# Creates the internet gateway.
resource "aws_internet_gateway" "lab03-gw" {
  vpc_id = aws_vpc.lab03-vpc.id

  tags = {
    Name = "lab03-gw"
  }
}

# Creates the route table.
resource "aws_route_table" "lab03-route-table" {
  vpc_id = aws_vpc.lab03-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab03-gw.id
  }

  tags = {
    Name = "lab03-route-table"
  }
}

# Associates the route table to the first public subnet
resource "aws_route_table_association" "lab03-route-assoc-1" {
  subnet_id      = aws_subnet.lab03-public-1.id
  route_table_id = aws_route_table.lab03-route-table.id
}

# Associates the route table to the second public subnet
resource "aws_route_table_association" "lab03-route-assoc-2" {
  subnet_id      = aws_subnet.lab03-public-2.id
  route_table_id = aws_route_table.lab03-route-table.id
}

# Creates the security group for the EC2-Nginx server.
resource "aws_security_group" "lab03-secgroup-1" {
  name        = "lab03-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab03-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab03-secgroup-1"
  }
}

# Creates the EC2 instance with NGINX installed
resource "aws_instance" "lab03-node-1" {
  instance_type               = var.instance_type
  ami                         = var.amis[var.aws_region]
  key_name                    = aws_key_pair.lab03-keypair.id
  vpc_security_group_ids      = [aws_security_group.lab03-secgroup-1.id]
  subnet_id                   = aws_subnet.lab03-public-1.id
  associate_public_ip_address = true
  user_data                   = file("webserver.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "lab03-node-1"
  }
}

# Imports the keypair
resource "aws_key_pair" "lab03-keypair" {
  key_name   = "lab03-keypair"
  public_key = file("~/.ssh/tf-keypair.pub")
}
