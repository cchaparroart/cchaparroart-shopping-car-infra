resource "aws_s3_bucket" "base_02" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "base_03" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "Demo"
    Environment = "Dev"
  }
}