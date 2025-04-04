data "archive_file" "this" {
  type        = var.archive_file.type
  source_file = var.archive_file.source_file
  output_path = var.archive_file.output_path
}

resource "aws_iam_role" "this" {
  name = format("%s-lambda-iam-role", var.function_name)
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      }
    ],
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policies)
  role       = aws_iam_role.this.id
  policy_arn = var.policies[count.index]
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  role             = aws_iam_role.this.arn
  s3_bucket        = var.s3_bucket_id
  s3_key           = var.function_name
  source_code_hash = data.archive_file.this.output_base64sha256

  environment {
    variables = var.environment_variables
  }
  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }
}

resource "aws_cloudwatch_log_group" "this" {
  depends_on        = [aws_lambda_function.this]
  name              = format("/aws/lambda/%s", var.function_name)
  retention_in_days = 7
}

resource "aws_s3_object" "this" {
  bucket      = var.s3_bucket_id
  key         = var.function_name
  source      = data.archive_file.this.output_path
  source_hash = data.archive_file.this.output_base64sha256
}