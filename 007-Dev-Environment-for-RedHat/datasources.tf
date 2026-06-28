# RedHat AMI
# To get AMI info, check for specific AMI in the console, then run this in AWS CLI.
# aws ec2 describe-images --image <AMI-ID> --region <REGION>

# data "aws_ami" "tst-ami" {
#   most_recent = true
#   owners      = ["309956199498"]

#   filter {
#     name   = "name"
#     values = ["309956199498/RHEL-8.6.0_HVM-20220503-x86_64-2-Hourly2-GP2"]
#   }
# }