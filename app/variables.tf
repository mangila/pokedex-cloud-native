variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "eventbridge_connection_user" {
  description = "Connection username"
  type        = string
  sensitive   = true
}

variable "eventbridge_connection_password" {
  description = "Connection password"
  type        = string
  sensitive   = true
}