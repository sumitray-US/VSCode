resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    id     = "delete-6-months-old"
    status = "Enabled"

    expiration {
      days = 180 # 6 months
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
