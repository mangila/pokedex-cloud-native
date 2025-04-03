output "generation_function_name" {
  value = module.generation.lambda_function.function_name
}

output "generation_function_zip" {
  value = module.generation.archive_file.output_path
}

output "generation_function_log_group" {
  value = module.generation.lambda_log_group.name
}