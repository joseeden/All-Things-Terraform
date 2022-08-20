my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"

aws_region = "ap-southeast-1"
avail_zone = [
  "ap-southeast-1a",
  "ap-southeast-1b",
  "ap-southeast-1c"
]

instance_type           = "t2.medium"
cidr_block              = "10.123.0.0/16"
map_public_ip_on_launch = true
enable_dns_hostnames    = true
enable_dns_support      = true
ebs_size                = "10"
aws_ami                 = "ami-051f0947e420652a9"

