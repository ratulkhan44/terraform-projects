variable "project_name" {
  description = "Project Name"
  type = string
  default = "Terraform Input Demo"
}

variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}

variable "aws_region" {
  description = "Aws Region Name"
  type = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-bucket"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = "10.0.0.1/16"
}