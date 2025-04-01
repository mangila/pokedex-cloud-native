data "archive_file" "hello_zip" {
  type        = "zip"
  source_dir  = "lambda_src/hello"
  output_path = "lambda_src/hello/bootstrap.zip"
}

resource "random_string" "random_string_generator" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}