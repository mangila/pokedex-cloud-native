variable "create_lambda_log_groups" {
  description = "Name of the Lambda function that creates log group /aws/lambda/<NAME>"
  type        = list(string)
}