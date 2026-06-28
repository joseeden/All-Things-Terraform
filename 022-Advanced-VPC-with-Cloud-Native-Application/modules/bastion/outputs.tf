output "public_ip" {
  description = "public ip address"
  value       = aws_instance.lab06-bastion.public_ip
}