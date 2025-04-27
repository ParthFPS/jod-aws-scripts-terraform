provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "JOD_static_bucket" {
  bucket = "jod-static-website-bucket-12345"  # must be globally unique
}

resource "aws_s3_bucket_notification" "JOD_bucket_notify" {
  bucket = aws_s3_bucket.JOD_static_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.JOD_s3_logger.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.JOD_allow_s3]
}
