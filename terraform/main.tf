resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-devsecops-bucket-12345"
  acl    = "public-read" # This will be flagged by tfsec
}

# A more secure version for comparison
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-devsecops-bucket-12345"
  acl    = "private"

  public_access_block {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}