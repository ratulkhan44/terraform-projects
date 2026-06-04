# Configure the AWS Provider
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}


provider "aws" {
    region = "us-east-1"
}

terraform{
    backend "s3" {
        bucket = "test-terraform-remote-backend-2026" 
        key    = "dev/terraform.tfstate"
        region = "us-east-1"
        use_lockfile  = "true"
        encrypt        = true
    }
}

# Create a S3 bucket
resource "aws_s3_bucket" "test_bucket" {
    bucket = "test-terraform-bucket-${random_string.bucket_suffix.result}"

    tags = {
        Name = "Test Bucket 1.0"
        Environment = "Dev"
  }
}

resource "random_string" "bucket_suffix" {
    length = 8
    special = false
    upper = false
}