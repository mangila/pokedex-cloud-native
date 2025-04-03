output "generation_function_name" {
  value = module.fetch_generation.lambda_function.function_name
}

output "generation_function_zip" {
  value = module.fetch_generation.archive_file.output_path
}

output "generation_function_log_group" {
  value = module.fetch_generation.lambda_log_group.name
}

output "generation_queue_name" {
  value = module.generation_queue.queue_name
}

output "generation_queue_url" {
  value = module.generation_queue.queue_url
}

output "generation_dead_queue_name" {
  value = module.generation_queue.dead_letter_queue_name
}

output "generation_dead_queue_url" {
  value = module.generation_queue.dead_letter_queue_url
}