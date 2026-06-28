resource "aws_instance" "lab06-mongo" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = filebase64("${path.module}/setup-mongodb.sh")

  tags = {
    Name  = "lab06-mongo"
  }
}