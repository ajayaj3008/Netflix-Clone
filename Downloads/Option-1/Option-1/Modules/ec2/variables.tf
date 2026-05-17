variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
  default = "Demo-Instance"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.medium"
  
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-ec2-key"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
  
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a56f8447277affd8"
  
}

variable "public_subnet_id" {
  description = "Public subnet ID for the EC2 instance"
  type        = string
  default     = "true"
  
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
  default     = "true"
  
}