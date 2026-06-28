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

variable "my_ip" {
  description = "My local machine's IP"
  type        = string
}

variable "cidr_block" {
  description = "VPC IP range"
  type        = string
}

variable "avail_zone" {
  description = "Availability zone"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Associate public IP during creation"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable_dns_hostnames"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable_dns_support"
  type        = bool
}

variable "instance_type" {
  description = "instance_type"
  type        = string
}

variable "aws_ami" {
  description = "instance_type"
  type        = string
  default     = ""
}



