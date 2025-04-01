resource "aws_cloudwatch_log_group" "example_lambda_log_group" {
  name              = format("/aws/lambda/%s", aws_lambda_function.example_lambda.function_name)
  retention_in_days = 7
}