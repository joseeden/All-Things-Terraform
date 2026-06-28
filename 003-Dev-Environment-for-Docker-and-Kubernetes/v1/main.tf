
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
    cidr_blocks = ["${var.my_ip}/32"]
    self        = true
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


resource "aws_key_pair" "tst-kp-ubuntu" {
  key_name   = "tst-kp-ubuntu"
  public_key = file("~/.ssh/tst-kp-ubuntu.pub")
}

resource "aws_instance" "node-master" {
  # ami                         = var.aws_ami
  ami                         = data.aws_ami.tst-ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tst-kp-ubuntu.id
  subnet_id                   = aws_subnet.tst-public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.tst-sg-1.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.tpl")

  connection {
    type        = "ssh"
    user        = "eden"
    private_key = file("~/.ssh/tst-kp-ubuntu")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-master",
      "sudo sed -i 's/localhost/localhost node-master/' /etc/hosts",
    ]
  }

  provisioner "local-exec" {
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-ubuntu"
    })

  }

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "node-master"
  }
}

resource "aws_instance" "node-worker1" {
  # ami                         = var.aws_ami
  ami                         = data.aws_ami.tst-ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tst-kp-ubuntu.id
  subnet_id                   = aws_subnet.tst-public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.tst-sg-1.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.tpl")

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "eden"
    private_key = file("~/.ssh/tst-kp-ubuntu")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-worker1",
      "sudo sed -i 's/localhost/localhost node-worker1/' /etc/hosts",
    ]
  }

  provisioner "local-exec" {
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-ubuntu"
    })

  }

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "node-worker1"
  }
}

resource "aws_instance" "node-worker2" {
  # ami                         = var.aws_ami
  ami                         = data.aws_ami.tst-ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tst-kp-ubuntu.id
  subnet_id                   = aws_subnet.tst-public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.tst-sg-1.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.tpl")

  connection {
    type        = "ssh"
    user        = "eden"
    private_key = file("~/.ssh/tst-kp-ubuntu")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-worker2",
      "sudo sed -i 's/localhost/localhost node-worker2/' /etc/hosts",
    ]
  }

  provisioner "local-exec" {
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-ubuntu"
    })

  }

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "node-worker2"
  }
}

resource "aws_instance" "node-worker3" {
  # ami                         = var.aws_ami
  ami                         = data.aws_ami.tst-ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.tst-kp-ubuntu.id
  subnet_id                   = aws_subnet.tst-public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.tst-sg-1.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.tpl")

  connection {
    type        = "ssh"
    user        = "eden"
    private_key = file("~/.ssh/tst-kp-ubuntu")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname node-worker3",
      "sudo sed -i 's/localhost/localhost node-worker3/' /etc/hosts",
    ]
  }

  provisioner "local-exec" {
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-ubuntu"
    })

  }

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "node-worker3"
  }
}