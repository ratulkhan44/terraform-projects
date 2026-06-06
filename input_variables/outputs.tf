output "bucket_name" {
  description = "Name of the S3 bucket"
  value = aws_s3_bucket.main_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value = aws_s3_bucket.main_bucket.arn
}

output "vpc_id" {
  description = "ID for VPC"
  value = aws_vpc.main_vpc.id
}

output "instance_id" {
  description = "ID for instance"
  value = aws_instance.web.id
}

output "environment" {
  description = "Environment for input variables"
  value = var.environment
}

output "tags" {
  description = "Tags from local variable"
  value       = local.common_tags
}