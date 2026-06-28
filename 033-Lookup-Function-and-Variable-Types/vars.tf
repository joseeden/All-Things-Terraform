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

# variables for the lab

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "cidr_block" {
  description = "IP Range"
  type        = string
}

variable "servername" {
  description = "Name of the server"
  type        = string
}

variable "subnet" {
  description = "subnet IP address space"
  type        = string
}

variable "os_type" {
  description = "OS to deploy, Linux or Windows"
  type        = string
}

variable "ec2_monitoring" {
  description = "Configure monitoring on the EC2 instance"
  type        = bool
}

variable "disk" {
  description = "OS image to deploy"
  type = object({
    delete_on_termination = bool
    encrypted             = bool
    volume_size           = string
    volume_type           = string
  })
}

variable "ami_ids" {
  type        = map(any)
  description = "AMI ID's to deploy"
}

variable "instance_size" {
  description = "Size of the EC2 instance"
  type        = string
  default     = "t2.micro"
}
