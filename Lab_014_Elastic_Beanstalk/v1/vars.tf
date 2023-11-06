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

#-----------------------------------------------------

variable "elasticapp" {
  default = ""
}

variable "beanstalkappenv" {
  default = ""
}

variable "solution_stack_name" {
  default = ""
}

variable "tier" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "public_subnets" {
  type = list(string)
}