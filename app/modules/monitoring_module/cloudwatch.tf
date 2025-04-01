resource "aws_cloudwatch_log_group" "create_lambda_log_groups" {
  count             = length(var.create_lambda_log_groups)
  name              = format("/aws/lambda/%s", var.create_lambda_log_groups[count.index])
  retention_in_days = 7
}