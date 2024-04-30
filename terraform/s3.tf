resource "aws_s3_bucket" "s3-bucket" {
  bucket = "s3-bucket-nti-final-project"

  lifecycle {
    prevent_destroy = true
  }


  tags = {
    Name = "s3-bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
