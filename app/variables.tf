variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "eventbridge_connection_user" {
  description = "Eventbridge connection username"
  type        = string
  sensitive   = true
}

variable "eventbridge_connection_password" {
  description = "Eventbridge connection password"
  type        = string
  sensitive   = true
}