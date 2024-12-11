output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.my_instance.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.my_instance.public_ip
}

output "private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.my_instance.private_ip
}