# A bucket to store access logs
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-secure-devsecops-log-bucket-12345"
}

# The main, fully secured S3 bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-devsecops-bucket-12345"

  # Enable versioning to protect against accidental deletion/modification
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable access logging
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}

# Define the public access block as a separate resource
resource "aws_s3_bucket_public_access_block" "secure_bucket_pab" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}