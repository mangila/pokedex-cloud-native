locals {
  common_tags = {
    Application = "pokedex-cloud-native"
    Environment = var.environment
    Owner       = "mangila"
  }
}