variable "create_lambdas" {
  description = "Create Lambda Function with these configurations"
  type = list(object({
    function_name         = string
    handler               = string
    runtime               = string
    timeout               = number
    role_arn              = string
    s3_bucket_id          = string
    s3_key                = string
    source_code_hash      = string
    environment_variables = map(string)
    vpc_config = object({
      subnet_ids         = list(string)
      security_group_ids = list(string)
    })
  }))
}