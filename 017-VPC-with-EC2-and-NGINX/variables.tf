# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
}

# Variables for creating the VPC and EC2 instances

variable "instance_type" {
  type = string
}

variable "avail_zones" {
  type = list(string)
}

variable "my_ip" {
  type = string
}

variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-04d9e855d716f9c99"
    "ap-northeast-1" : "ami-081ce1b631be2b337"
  }
}