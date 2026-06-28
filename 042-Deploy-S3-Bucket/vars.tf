# Variables for setting up terraform

variable "aws_region" {
  description = "AWS region"
  type        = string
}

# variable "my_profile" {
#   description = "Profile to be used to connect to AWS"
#   type        = string
# }

# variable "my_credentials" {
#   description = "Credentials to be used to connect to AWS"
#   type        = list(string)
# }

variable "environment" {
  description = "Environment"
  type = "string"
}


variable "bucket_name" {
  description = "Name of the S3 Bucket, should be globally unique"
  type = "string"
}

variable "bucket_tags" {
  description ="Tags assigned to the bucket"
  type = "map"
  default = {
    created_by = "terraform"
    environment = var.environment
   }
}