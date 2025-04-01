output "created_lambda_log_groups" {
  description = "Created Lambda CloudWatch log groups"
  value       = aws_cloudwatch_log_group.create_lambda_log_groups
}