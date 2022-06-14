
# This terraform template deploys a VPC with one public subnet, 
# internet gateway, route table, a security group, and one EC2 instance.

resource "aws_vpc" "tst-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "tst-vpc"
  }
}

resource "aws_subnet" "tst-public-subnet-1" {
  vpc_id                  = aws_vpc.tst-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.avail_zone[0]

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
    cidr_blocks = [var.my_ip]
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
  instance_type = var.instance_type
  ami           = data.aws_ami.tst-ami.id
  # ami                    = var.aws_ami
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
    Name = "tst-docker-k8s"
  }
}