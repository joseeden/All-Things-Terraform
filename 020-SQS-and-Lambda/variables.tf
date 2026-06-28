variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "my_credentials" {
  description = "Credentials to be used to connect to AWS"
  type        = list(string)
  default     = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
}

variable "my_profile" {
  description = "Profile to be used to connect to AWS"
  type        = string
  default     = "vscode-dev"
}