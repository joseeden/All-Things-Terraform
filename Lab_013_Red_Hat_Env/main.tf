
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

  # Allow traffic from personal laptop
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.my_ip]
  }

  # Allow traffic from SG itself
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # Alllow internet access
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


resource "aws_key_pair" "tst-kp-rhel" {
  key_name   = "tst-kp-rhel"
  public_key = file("~/.ssh/tst-kp-rhel.pub")
}

#---------------------------------------------------------------------
# RHEL Client - Most of the labs are done here.
#---------------------------------------------------------------------

resource "aws_instance" "tstrhel" {
  instance_type = var.instance_type
  # ami           = data.aws_ami.tst-ami.id
  ami                    = var.aws_ami
  key_name               = aws_key_pair.tst-kp-rhel.id
  vpc_security_group_ids = [aws_security_group.tst-sg-1.id]
  subnet_id              = aws_subnet.tst-public-subnet-1.id
  user_data              = file("userdata.tpl")

  ebs_block_device {
    device_name = "/dev/sda1"
    tags = {
      Name = "tstrhel-root"
    }
  }

  provisioner "local-exec" {
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-rhel"
    })
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tstrhel"
  }
}

#---------------------------------------------------------------------
# RHEL Server - for nfs, smb
#---------------------------------------------------------------------

resource "aws_instance" "tstrhel-nfs" {
  instance_type = var.instance_type
  # ami           = data.aws_ami.tst-ami.id
  ami                    = var.aws_ami
  key_name               = aws_key_pair.tst-kp-rhel.id
  vpc_security_group_ids = [aws_security_group.tst-sg-1.id]
  subnet_id              = aws_subnet.tst-public-subnet-1.id
  user_data              = file("userdata-nfs.tpl")

  ebs_block_device {
    device_name = "/dev/sda1"
    tags = {
      Name = "tstrhel-nfs-root"
    }
  }

  provisioner "local-exec" {
    command = templatefile("ssh-linux.tpl", {
      hostname     = self.public_ip,
      user         = "eden",
      identityfile = "~/.ssh/tst-kp-rhel"
    })
    # interpreter = ["Powershell", "-Command"]
    interpreter = ["bash", "-c"]
  }

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "tstrhel-nfs"
  }
}

#---------------------------------------------------------------------
# Additional EBS section
#---------------------------------------------------------------------

resource "aws_ebs_volume" "tst_ebs1" {
  availability_zone = var.avail_zone[0]
  size              = var.ebs_size

  tags = {
    Name = "tst_ebs1"
  }
}

resource "aws_volume_attachment" "tst_ebs1_attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.tst_ebs1.id
  instance_id = aws_instance.tstrhel.id
}

#----------------------------------------------

resource "aws_ebs_volume" "tst_ebs2" {
  availability_zone = var.avail_zone[0]
  size              = var.ebs_size

  tags = {
    Name = "tst_ebs2"
  }
}

resource "aws_volume_attachment" "tst_ebs2_attach" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.tst_ebs2.id
  instance_id = aws_instance.tstrhel.id
}

#----------------------------------------------

resource "aws_ebs_volume" "tst_ebs3" {
  availability_zone = var.avail_zone[0]
  size              = var.ebs_size

  tags = {
    Name = "tst_ebs3"
  }
}

resource "aws_volume_attachment" "tst_ebs3_attach" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.tst_ebs3.id
  instance_id = aws_instance.tstrhel.id
}

#----------------------------------------------

resource "aws_ebs_volume" "tst_ebs4" {
  availability_zone = var.avail_zone[0]
  size              = var.ebs_size

  tags = {
    Name = "tst_ebs4"
  }
}

resource "aws_volume_attachment" "tst_ebs4_attach" {
  device_name = "/dev/sde"
  volume_id   = aws_ebs_volume.tst_ebs4.id
  instance_id = aws_instance.tstrhel.id
}