# Resource: Security Group (Optional, for SSH access)
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow SSH access to the EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust for specific IP ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Resource: EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  # Associate public IP address
  associate_public_ip_address = true

  # Assign security group
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  # Tags
  tags = {
    Name = var.instance_name
  }
}
