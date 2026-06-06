resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-vpc"
    }
  )
}


resource "aws_s3_bucket" "main_bucket" {
  bucket = local.full_bucket_name
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-bucket"
    }
  )
}


resource "aws_instance" "web" {
  ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = var.instance_type
  tags = {
    Name = "${var.environment}-web"
  }
}