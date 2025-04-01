output "hello_zip_object_source_hash" {
  description = "hello-bootstrap.zip - source hash"
  value       = data.archive_file.hello_zip.output_base64sha256
}

output "example_lambda_log_group" {
  description = "Lambda function log group"
  value       = aws_cloudwatch_log_group.example_lambda_log_group.name
}

output "example_lambda_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.example_lambda.function_name
}

output "pokedex_lambda_bucket" {
  value       = aws_s3_bucket.pokedex_lambda_bucket.bucket
  description = "Bucket name"
}