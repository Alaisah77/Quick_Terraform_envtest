output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.my_instance.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.my_instance.public_ip
}

output "private_key_path" {
  description = "Path to the private key file for the instance."
  value       = local_file.private_key.filename
}

output "ami_id" {
  description = "The AMI ID of the instance."
  value       = data.aws_ami.rhel_ami.id
}

