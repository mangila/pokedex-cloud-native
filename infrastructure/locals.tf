locals {
  common_tags = {
    Application = "pokedex-cloud-native"
    Environment = var.application_environment
    Owner       = "mangila"
  }
}