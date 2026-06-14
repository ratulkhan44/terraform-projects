resource "aws_s3_bucket" "bucket_website" {
  bucket = var.bucket_name

  tags = {
    Name = "Terraform Static Website Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_website_config" {
  bucket = aws_s3_bucket.bucket_website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.bucket_website.id

  block_public_acls = false
  ignore_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.bucket_website.id

  depends_on = [ aws_s3_bucket.bucket_website ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
        {
            Sid = "PublicRead"
            Effect = "Allow"
            Principal = "*"
            Action = [
                "s3:GetObject"
            ]
            Resource = "${aws_s3_bucket.bucket_website.arn}/*"
        }
    ]
  })
}

resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/website","**")

  bucket = aws_s3_bucket.bucket_website.id
  key = each.value
  source = "${path.module}/website/${each.value}"
  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      png  = "image/png"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      svg  = "image/svg+xml"
      ico  = "image/x-icon"
    },
    reverse(split(".",each.value))[0],
    "application/octet-stream"
  )
}
