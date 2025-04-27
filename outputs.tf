output "JOD_website_bucket" {
  value = aws_s3_bucket.JOD_static_bucket.bucket
}

output "JOD_lambda_function_name" {
  value = aws_lambda_function.JOD_s3_logger.function_name
}

output "JOD_lambda_function_arn" {
  value = aws_lambda_function.JOD_s3_logger.arn
}
