variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  sensitive   = false
}

variable "handler" {
  description = "Lambda function entrypoint"
  type        = string
  default     = "bootstrap"
  sensitive   = false
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "provided.al2023"
  sensitive   = false
}

variable "timeout" {
  description = "Lambda function timeout"
  type        = number
  default     = 3
  sensitive   = false
}

variable "policies" {
  description = "List of policies to be attached from the function code"
  type        = list(string)
  sensitive   = false
}

variable "s3_bucket_id" {
  description = "S3 build bucket id"
  type        = string
}

variable "archive_file" {
  description = "The Lambda Zip Archive"
  type = object({
    type        = string
    source_file = string
    output_path = string
  })
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}