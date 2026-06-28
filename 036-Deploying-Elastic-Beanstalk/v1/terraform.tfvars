my_credentials = ["/mnt/c/Users/Eden.Jose/.aws/credentials"]
my_profile     = "vscode-dev"
aws_region     = "ap-southeast-1"

# Beanstalk
tier                = "WebServer"
elasticapp          = "react-app-1"
beanstalkappenv     = "react-app-1-env"
solution_stack_name = "64bit Amazon Linux 2 v3.4.18 running Docker"
vpc_id              = "vpc-fa07179d"
public_subnets = [
  "subnet-6fc73227",
  "subnet-6e33f608",
  "subnet-3d78c864"
]

