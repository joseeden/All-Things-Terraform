# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"
key_pair       = "tf-user-keypair"

# Variables for creating the VPC and EC2 instances
availability_zones    = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
cidr_block            = "10.0.0.0/16"
bastion_instance_type = "t3.micro"
app_instance_type     = "t3.micro"
db_instance_type      = "t3.micro"

# AMI for bastion and mongodb
# Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
instance_ami = "ami-04d9e855d716f9c99"