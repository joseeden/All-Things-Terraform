output "vpc_id" {
  value = aws_vpc.lab03-vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.lab03-public-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.lab03-public-2.id
}

output "server_public_ip" {
  value = aws_instance.lab03-node-1.public_ip
}