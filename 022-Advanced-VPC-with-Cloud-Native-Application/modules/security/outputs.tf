output "application_sg_id" {
  description = "web server sg id"
  value       = aws_security_group.lab06-sg-application.id
}

output "alb_sg_id" {
  description = "alb sg id"
  value       = aws_security_group.lab06-sg-alb.id
}

output "mongodb_sg_id" {
  description = "mongodb sg id"
  value       = aws_security_group.lab06-sg-mongodb.id
}

output "bastion_sg_id" {
  description = "bastion sg id"
  value       = aws_security_group.lab06-sg-bastion.id
}