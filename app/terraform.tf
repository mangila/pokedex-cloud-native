terraform {
  required_version = "~> 1.11.2, < 2.0"
  cloud {
    organization = "mangila"
    workspaces {
      name = "pokedex-cloud-native-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1, < 6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.2, < 3.0"
    }
  }
}