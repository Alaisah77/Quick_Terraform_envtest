# Fetch the latest Red Hat Enterprise Linux AMI (free-tier eligible)
data "aws_ami" "rhel_ami" {
  most_recent = true
  owners      = ["309956199498"]  # AWS Red Hat AMI owner ID
  filter {
    name   = "name"
    values = ["RHEL-7.*GA*"]  # Adjust this if you need a different version
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Create a new key pair and store the private key locally
resource "aws_key_pair" "generated_key" {
  key_name   = "my-generated-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with your actual public key path
}

# Save the private key locally (Optional: if a new key pair is generated)
resource "local_file" "private_key" {
  content  = tls_private_key.generated_key.private_key_pem
  filename = "${path.module}/my-generated-key.pem"
  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/my-generated-key.pem"
  }
}

# Generate a private/public key pair (Optional: if generating a new key pair)
resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Security Group to allow SSH access
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow SSH access to the EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instance
resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.rhel_ami.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = var.instance_name
  }
}
