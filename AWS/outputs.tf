output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.linux-eip.address 
}
output "instance_public_dns" {
  value = aws_instance.linux-server.public_dns
}


