output "enrich_pokemon_name" {
  value = module.enrich_pokemon.lambda_function.function_name
}

output "fetch_generation_name" {
  value = module.fetch_generation.lambda_function.function_name
}

output "persist_pokemon_name" {
  value = module.persist_pokemon.lambda_function.function_name
}

output "pokemon_sqs_name" {
  value = module.pokemon_sqs.queue_name
}

output "pokemon_sqs_url" {
  value = module.pokemon_sqs.queue_url
}

output "pokemon_dlq_name" {
  value = module.pokemon_sqs.dead_letter_queue_name
}

output "pokemon_dlq_url" {
  value = module.pokemon_sqs.dead_letter_queue_url
}