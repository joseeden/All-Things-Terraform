output "node-master-ip" {
  value = aws_instance.node-master.public_ip
}

output "node-worker1-ip" {
  value = aws_instance.node-worker1.public_ip
}

output "node-worker2-ip" {
  value = aws_instance.node-worker2.public_ip
}

output "node-worker3-ip" {
  value = aws_instance.node-worker3.public_ip
}

