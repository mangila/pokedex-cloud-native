data "archive_file" "hello_zip" {
  type        = "zip"
  source_file = local.lambda_config.hello.source_file
  output_path = format("%s/%s",
    local.lambda_config.hello.source_dir,
    local.lambda_config.hello.build_bucket_key
  )
}