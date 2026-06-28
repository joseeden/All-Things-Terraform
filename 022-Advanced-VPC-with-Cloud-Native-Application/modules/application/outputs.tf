output "dns_name" {
  description = "alb dns"
  value       = aws_lb.lab06-alb.dns_name
}

output "private_ips" {
  description = "application instance private ips"
  value       = data.aws_instances.application.private_ips
}