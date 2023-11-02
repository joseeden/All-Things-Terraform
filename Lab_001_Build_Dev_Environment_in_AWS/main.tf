
# This terraform template deploys a VPC with one public subnet, 
# internet gateway, route table, a security group, and one EC2 instance.

resource "aws_vpc" "tst-vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tst-vpc"
  }
}

resource "aws_subnet" "tst-public-subnet-1" {
  vpc_id                  = aws_vpc.tst-vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "tst-public-subnet-1"
  }
}

resource "aws_internet_gateway" "tst-igw-1" {
  vpc_id = aws_vpc.tst-vpc.id

  tags = {
    Name = "tst-igw-1"
  }
}

resource "aws_route_table" "tst-rt-table" {
  vpc_id = aws_vpc.tst-vpc.id

  tags = {
    Name = "tst-rt-table"
  }
}

resource "aws_route" "tst-rt-route" {
  route_table_id         = aws_route_table.tst-rt-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tst-igw-1.id
}

resource "aws_route_table_association" "tst-rt-assoc-1" {
  subnet_id      = aws_subnet.tst-public-subnet-1.id
  route_table_id = aws_route_table.tst-rt-table.id
}

resource "aws_security_group" "tst-sg-1" {
  name        = "tst-sg-1"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.tst-vpc.id

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
    Name = "tst-sg-1"
  }
}

resource "aws_key_pair" "tst-keypair" {
  key_name   = "tst-keypair"
  public_key = file("~/.ssh/tst-keypair.pub")
}

resource "aws_instance" "tst-node-1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.tst-ami.id
  key_name               = aws_key_pair.tst-keypair.id
  vpc_security_group_ids = [aws_security_group.tst-sg-1.id]
  subnet_id              = aws_subnet.tst-public-subnet-1.id
  user_data              = file("userdata.tpl")

  provisioner "local-exec" {
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/tst-keypair"
    })
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tst-node-1"
  }
}