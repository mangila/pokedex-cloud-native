variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "eventbridge_connection_user" {
  description = "EventBridge connection username"
  type        = string
  sensitive   = true
}

variable "eventbridge_connection_password" {
  description = "EventBridge connection password"
  type        = string
  sensitive   = true
}