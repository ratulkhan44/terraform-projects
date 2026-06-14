provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Hosting Static Site in S3"
      Topic       = "Hosting Static Website"
      ManagedBy   = "Terraform"
      Environment = "dev"
    }
  }
}
