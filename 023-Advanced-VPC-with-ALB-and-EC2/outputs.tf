output "vpc_id" {
  value = aws_vpc.lab04-vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.lab04-public-subnet-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.lab04-public-subnet-2.id
}

output "private_subnet1_id" {
  value = aws_subnet.lab04-private-subnet-1.id
}

output "private_subnet2_id" {
  value = aws_subnet.lab04-private-subnet-2.id
}

output "alb_dns_name" {
  description = "alb dns"
  value       = aws_lb.lab04-alb.dns_name
}
