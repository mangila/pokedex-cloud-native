resource "random_string" "bucket_name_generator" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "aws_s3_bucket" "pokedex_lambda_bucket" {
  bucket = format("pokedex-lambda-bucket-%s", random_string.bucket_name_generator.result)
}

output "pokedex_lambda_bucket" {
  value       = aws_s3_bucket.pokedex_lambda_bucket.bucket
  description = "Bucket name"
}

data "archive_file" "hello_zip" {
  type        = "zip"
  source_dir  = "lambda_src/hello"
  output_path = "lambda_src/hello/bootstrap.zip"
}

resource "aws_s3_object" "hello_s3_object" {
  bucket      = aws_s3_bucket.pokedex_lambda_bucket.id
  key         = "hello-bootstrap.zip"
  source      = data.archive_file.hello_zip.output_path
  source_hash = data.archive_file.hello_zip.output_base64sha256
}

output "hello_s3_object_source_hash" {
  description = "hello-bootstrap.zip - source hash"
  value       = data.archive_file.hello_zip.output_base64sha256
}