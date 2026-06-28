# terraform {
#   required_version = ">= 0.12"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 4.16.0"
#     }
#   }

# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.30.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}