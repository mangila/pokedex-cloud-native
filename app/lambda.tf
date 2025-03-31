resource "aws_lambda_function" "example_lambda" {
  function_name    = "example-lambda"
  runtime          = "provided.al2023"
  handler          = "bootstrap"
  role             = aws_iam_role.lambda_execution_role.arn
  source_code_hash = data.archive_file.hello_zip.output_base64sha256
  s3_bucket        = aws_s3_bucket.pokedex_lambda_bucket.id
  s3_key           = aws_s3_object.hello_s3_object.key
  vpc_config {
    subnet_ids         = [aws_subnet.pokedex_subnet.id]
    security_group_ids = [aws_security_group.pokeapi_sg.id]
  }
}

resource "aws_cloudwatch_log_group" "example_lambda_log_group" {
  name              = format("/aws/lambda/%s", aws_lambda_function.example_lambda.function_name)
  retention_in_days = 7
}

output "example_lambda_log_group" {
  description = "Lambda function log group"
  value       = aws_cloudwatch_log_group.example_lambda_log_group.name
}

output "example_lambda_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.example_lambda.function_name
}