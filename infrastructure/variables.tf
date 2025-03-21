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
  default     = "eu-north-1"
  sensitive   = false
}

variable "environment" {
  type        = string
  description = "Environment for the infrastructure"
  default     = "development"
  sensitive   = false
}