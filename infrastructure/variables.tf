variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources will be created"
  sensitive   = false
}

variable "application_environment" {
  type        = string
  description = "Application environment for the infrastructure (dev, test, prod, etc..)"
  sensitive   = false
}