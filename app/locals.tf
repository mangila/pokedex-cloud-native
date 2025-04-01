locals {
  lambda_config = {
    "hello" = {
      function_name    = "hello"
      source_dir       = "lambda_src/hello"
      source_file      = "lambda_src/hello/bootstrap"
      build_bucket_key = "hello-bootstrap.zip"
      handler          = "bootstrap"
      runtime          = "provided.al2023"
    }
  }
}