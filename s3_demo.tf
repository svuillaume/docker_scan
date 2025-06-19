provider "aws" {
  region = "ca-central-1"  # or your preferred region
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "public-demo-bucket-1234"  # must be globally unique
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "public_bucket_ownership" {
  bucket = aws_s3_bucket.public_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetO
