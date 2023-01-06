# Variables for setting up terraform
aws_region     = "ap-southeast-1"
my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "tf-user"

# Variables for the lab
cidr_block        = "10.0.0.0/16"
availability_zone = "ap-southeast-1a"
servername        = "lab09-server"
subnet            = "10.0.1.0/24"
os_type           = "linux"
ec2_monitoring    = true

disk = {
  delete_on_termination = false
  encrypted             = true
  volume_size           = "20"
  volume_type           = "standard"
}

ami_ids = {
  linux   = "ami-04d9e855d716f9c99"
  windows = "ami-07d9bd7bc4f2370d0"
}