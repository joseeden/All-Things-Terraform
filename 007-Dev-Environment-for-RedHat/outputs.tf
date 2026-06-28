output "tstrhel-ip-public" {
  value = aws_instance.tstrhel.public_ip
}

output "tstrhel-ip-private" {
  value = aws_instance.tstrhel.private_ip
}

output "tstrhel-nfs-ip-public" {
  value = aws_instance.tstrhel-nfs.public_ip
}

output "tstrhel-nfs-ip-private" {
  value = aws_instance.tstrhel-nfs.private_ip
}