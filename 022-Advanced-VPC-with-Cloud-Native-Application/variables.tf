# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}


# Variables for creating the VPC and EC2 instances

variable "key_pair" {
  description = "Key name"
  type        = string
}

# AMI for bastion and mongodb
variable "instance_ami" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "app_instance_type" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}

variable "cidr_block" {
  type = string
}

variable "my_ip" {
  type = string
}

