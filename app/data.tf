data "archive_file" "hello_zip" {
  type        = "zip"
  source_file = local.lambda_config.hello.source_file
  output_path = local.lambda_config.hello.zip_file_name
}