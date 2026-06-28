# lab09-Lookup Function and Different Types of Variables
#--------------------------------------------------------

resource "aws_vpc" "lab09-vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "lab09-subnet" {
  vpc_id            = aws_vpc.lab09-vpc.id
  cidr_block        = var.subnet
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.servername}subnet"
  }
}

resource "aws_instance" "server" {
  ami                    = lookup(var.ami_ids, var.os_type, null)
  instance_type          = var.instance_size
  monitoring             = var.ec2_monitoring
  vpc_security_group_ids = [aws_vpc.lab09-vpc.default_security_group_id]
  subnet_id              = aws_subnet.lab09-subnet.id
  root_block_device {
    delete_on_termination = var.disk.delete_on_termination
    encrypted             = var.disk.encrypted
    volume_size           = var.disk.volume_size
    volume_type           = var.disk.volume_type
  }
  tags = {
    Name = var.servername
  }
}