provider "aws" {
  region = "us-east-1"
}

#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "adamumj" {
  bucket = "my-tf-adamumj-bucket-0477"
}

resource "aws_s3_bucket_ownership_controls" "adamumj" {
  bucket = aws_s3_bucket.adamumj.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "adamumj" {
  depends_on = [aws_s3_bucket_ownership_controls.adamumj]

  bucket = aws_s3_bucket.adamumj.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "adamumj" {
  bucket = aws_s3_bucket.adamumj.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning_adamumj" {
  bucket = aws_s3_bucket.adamumj.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_s3_bucket_server_side_encryption_configuration" "adamumj" {
  bucket = aws_s3_bucket.adamumj.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
