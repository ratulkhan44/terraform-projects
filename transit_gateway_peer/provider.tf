provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Establish Transit Gateway between 3 VPC"
      Topic       = "Transit Gateway"
      ManagedBy   = "Terraform"
      Environment = "dev"
    }
  }
}