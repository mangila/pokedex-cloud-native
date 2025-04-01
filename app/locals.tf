locals {
  common_tags = {
    Application = "pokedex-cloud-native"
    Environment = var.application_environment
    Owner       = "mangila"
  }
  pokeapi_ip_addresses = [
    # pokeapi.co
    "104.21.76.139/32",
    "172.67.195.193/32"
  ]
  pokeapi_media_ip_addresses = [
    # raw.githubusercontent.com
    "185.199.110.133/32",
    "185.199.111.133/32",
    "185.199.108.133/32",
    "185.199.109.133/32"
  ]
}