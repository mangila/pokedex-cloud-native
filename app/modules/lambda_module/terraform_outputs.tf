output "lambda_function" {
  value = aws_lambda_function.this
}

output "lambda_log_group" {
  value = aws_cloudwatch_log_group.this
}

output "s3_object" {
  value = aws_s3_object.this
}

output "archive_file" {
  value = data.archive_file.this
}

output "iam_role" {
  value = aws_iam_role.this
}