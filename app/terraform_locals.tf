locals {
  lambda_config = {
    "generation" = {
      function_name = "generation"
      source_file   = "lambda_src/generation/bootstrap"
      zip_file_name = "generation-lambda.zip"
      handler       = "bootstrap"
      runtime       = "provided.al2023"
    }
  }
}

data "archive_file" "generation_lambda_zip" {
  type        = "zip"
  source_file = local.lambda_config.generation.source_file
  output_path = local.lambda_config.generation.zip_file_name
}