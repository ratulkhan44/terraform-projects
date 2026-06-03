# Create a Simple S3 Bucket
resource "aws_s3_bucket" "test_bucket" {
    bucket = "test-terraform-bucket-2026"

    tags = {
        Name = "Test Bucket 1.0"
        Environment = "Dev"
    }
}