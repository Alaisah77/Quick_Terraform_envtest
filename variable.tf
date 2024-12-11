variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t2.micro"  # Free-tier eligible instance type
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
  default     = "MyInstance"
}

variable "vpc_id" {
  description = "The ID of the VPC where the instance will be deployed."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be deployed."
  type        = string
}
