variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.small"
}

variable "ami_id" {
  description = "AMI ID for Linux/UNIX"
  type        = string
  default     = "ami-00565a15a71e4402a"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "~/.ssh/minecraft_key.pub"
}