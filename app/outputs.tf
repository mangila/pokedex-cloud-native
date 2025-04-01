output "lambda_build_s3_bucket" {
  description = "The S3 bucket used for storing Lambda source code"
  value       = module.storage_module.lambda-build-s3-bucket.bucket
}

output "created_lambda_archive_s3_objects" {
  description = "Lambda S3 objects with Lambda source code"
  value = [
    for s3_obj in module.storage_module.created_lambda_archive_s3_objects : {
      bucket      = s3_obj.bucket
      key         = s3_obj.key
      source      = s3_obj.source
      source_hash = s3_obj.source_hash
    }
  ]
}

output "created_lambda_log_group_names" {
  value = [for log_group in module.monitoring_module.created_lambda_log_groups : log_group.name]
}

output "created_lambdas_details" {
  description = "Details of the created Lambda functions"
  value = [
    for lambda in module.compute_module.created_lambdas : {
      function_name    = lambda.function_name
      source_code_hash = lambda.source_code_hash
      s3_key           = lambda.s3_key
    }
  ]
}

output "lambda_execution_role_name" {
  description = "An IAM role for Lambda function execution"
  value       = module.security_module.lambda_execution_role.name
}