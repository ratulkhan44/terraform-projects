terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-for-vpc-peering-test"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}