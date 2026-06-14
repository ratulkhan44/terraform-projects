variable "aws_region"{
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Globally Unique Bucket Name"
  type = string
  default = "test-bucket-2026-06-14"
}

variable "environment" {
  description = "Environment name (dev or staging or prod)"
  type = string
  default = "dev"
}