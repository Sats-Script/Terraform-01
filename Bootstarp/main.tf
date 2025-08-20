terraform {
  required_version = ">= 1.6.0"
  # NOTE: No backend block here yet → use local state for the very first apply
}

  provider "aws" {
     region = "ap-south-1" # Mumbai
}

# ---------------- S3 state bucket ----------------
    resource "aws_s3_bucket" "tf_state" {
     bucket = "satish-prod-tf-state" # <--- must be globally unique

   tags = {
    Name        = "tf-state"
      Environment = "platform"
    Owner       = "satish"
  }

  # Safety: don’t let someone destroy the state bucket by mistake
    lifecycle {
     prevent_destroy = true
  }
}

# Versioning (keeps history of state)
   resource "aws_s3_bucket_versioning" "v" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration { status = "Enabled" }
}

# Encrypt objects at rest (SSE-S3 AES256)
     resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
          bucket = aws_s3_bucket.tf_state.id
    rule {
           apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
     }
}

# Block any public access
resource "aws_s3_bucket_public_access_block" "pab" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle: clean up old versions (keeps current version)
resource "aws_s3_bucket_lifecycle_configuration" "lc" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    id     = "versions-retention"
    status = "Enabled"
    filter {}
    noncurrent_version_expiration { noncurrent_days = 90 }
  }
}

# ---------------- DynamoDB lock table ----------------
resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "tf-locks"
    Environment = "platform"
    Owner       = "satish"
  }
}

# Handy outputs
output "state_bucket" {
  value = aws_s3_bucket.tf_state.bucket
}
output "lock_table" {
  value = aws_dynamodb_table.tf_lock.name
}
