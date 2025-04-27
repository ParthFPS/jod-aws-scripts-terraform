resource "aws_iam_role" "JOD_lambda_role" {
  name = "JOD_lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "JOD_lambda_policy" {
  name = "JOD_lambda_s3_logs_policy"
  role = aws_iam_role.JOD_lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup","logs:CreateLogStream","logs:PutLogEvents"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.JOD_static_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_lambda_function" "JOD_s3_logger" {
  function_name    = "JOD_s3_event_logger"
  runtime          = "python3.8"
  role             = aws_iam_role.JOD_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  filename         = "${path.module}/lambda_function_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_payload.zip")
}

resource "aws_lambda_permission" "JOD_allow_s3" {
  statement_id  = "JOD_AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
  function_name = aws_lambda_function.JOD_s3_logger.function_name
  source_arn    = aws_s3_bucket.JOD_static_bucket.arn
}
