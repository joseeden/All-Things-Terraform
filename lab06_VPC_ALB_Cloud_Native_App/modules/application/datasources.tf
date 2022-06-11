data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical
  owners = ["099720109477"]
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  #userdata
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/install-frontend-api.sh")
  }
}

# Scans instances tagged with
data "aws_instances" "application" {
  instance_tags = {
    Name  = "lab06-frontend-app"
    Owner = "Eden-Jose"
  }

  instance_state_names = ["pending", "running"]

  depends_on = [
    aws_autoscaling_group.lab06-asg
  ]
}