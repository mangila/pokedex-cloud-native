locals {
  lambda_config = {
    "hello" = {
      function_name = "hello"
      source_file   = "lambda_src/hello/bootstrap"
      zip_file_name = "hello-bootstrap.zip"
      handler       = "bootstrap"
      runtime       = "provided.al2023"
    }
  }
}