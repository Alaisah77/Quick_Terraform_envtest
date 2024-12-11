variable "vpc_id" {
  description = "The ID of the VPC where the instance will be deployed."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be deployed."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t2.micro"      # Default instance type
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instance."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
  default     = "MyInstance"
}
