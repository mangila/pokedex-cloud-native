resource "aws_lambda_function" "created_lambdas" {
  count = length(var.create_lambdas)

  function_name    = var.create_lambdas[count.index].function_name
  handler          = var.create_lambdas[count.index].handler
  runtime          = var.create_lambdas[count.index].runtime
  role             = var.create_lambdas[count.index].role_arn
  s3_bucket        = var.create_lambdas[count.index].s3_bucket_id
  s3_key           = var.create_lambdas[count.index].s3_key
  source_code_hash = var.create_lambdas[count.index].source_code_hash
  environment {
    variables = var.create_lambdas[count.index].environment_variables
  }
  vpc_config {
    subnet_ids         = var.create_lambdas[count.index].vpc_config.subnet_ids
    security_group_ids = var.create_lambdas[count.index].vpc_config.security_group_ids
  }
}