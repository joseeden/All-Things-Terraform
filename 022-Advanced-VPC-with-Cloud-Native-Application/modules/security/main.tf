resource "aws_security_group" "lab06-sg-bastion" {
  name        = "lab06-sg-bastion"
  description = "bastion network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "22 from workstation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.workstation_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-alb" {
  name        = "lab06-sg-alb"
  description = "alb network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lab06-sg-application.id]
  }

  tags = {
    Name = "allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-application" {
  name        = "lab06-sg-application"
  description = "application network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "80 from alb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    #security_groups  = [aws_security_group.alb.id]
  }

  ingress {
    description = "8080 from alb"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    #security_groups  = [aws_security_group.alb.id]
  }

  ingress {
    description     = "22 from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lab06-sg-bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "application allow traffic"
  }
}

resource "aws_security_group" "lab06-sg-mongodb" {
  name        = "lab06-sg-mongodb"
  description = "mongodb network traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "27017 from application"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    #cidr_blocks      = ["10.0.0.0/16"]
    security_groups = [aws_security_group.lab06-sg-application.id]
  }

  ingress {
    description     = "22 from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lab06-sg-bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab06-sg-mongodb"
  }
}