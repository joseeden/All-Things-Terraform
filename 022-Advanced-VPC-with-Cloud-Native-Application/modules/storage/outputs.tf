output "private_ip" {
  description = "private ip address"
  value       = aws_instance.lab06-mongo.private_ip
}