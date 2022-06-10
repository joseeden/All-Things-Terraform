resource "aws_instance" "lab06-bastion" {
  ami                         = "ami-02868af3c3df4b3aa"
  instance_type               = var.instance_type
  key_name                    = var.my_credentials
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  tags = {
    Name  = "lab06-bastion"
  }
}