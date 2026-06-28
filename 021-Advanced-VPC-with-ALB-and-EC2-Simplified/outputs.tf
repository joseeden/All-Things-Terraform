output "vpc_id" {
  value = aws_vpc.lab04-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.lab04-public-subnet.*.id
}

output "private_subnet_id" {
  value = aws_subnet.lab04-private-subnet.*.id
}

output "public_cidr_blocks" {
  value = aws_subnet.lab04-public-subnet.*.cidr_block
}

output "private_cidr_blocks" {
  value = aws_subnet.lab04-private-subnet.*.cidr_block
}

output "alb_dns_name" {
  description = "alb dns"
  value       = aws_lb.lab04-alb.dns_name
}
