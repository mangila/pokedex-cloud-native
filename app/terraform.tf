terraform {
  cloud {
    organization = "mangila"
    workspaces {
      name = "pokedex-cloud-native-workspace"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  default_tags {
    tags = {
      Application = "pokedex-cloud-native"
      Environment = var.application_environment
      Owner       = "mangila"
    }
  }
}

module "messaging_module" {
  source = "./modules/messaging_module"
}

module "network_module" {
  source = "./modules/network_module"
  pokeapi_address_ranges = [
    # pokeapi.co
    "104.21.76.139/32",
    "172.67.195.193/32"
  ]
  pokeapi_media_address_ranges = [
    # raw.githubusercontent.com
    "185.199.110.133/32",
    "185.199.111.133/32",
    "185.199.108.133/32",
    "185.199.109.133/32"
  ]
}

module "security_module" {
  source = "./modules/security_module"
}

module "storage_module" {
  source = "./modules/storage_module"

  create_lambda_archive_s3_objects = [
    {
      key         = local.lambda_config.hello.build_bucket_key
      source      = data.archive_file.hello_zip.output_path
      source_hash = data.archive_file.hello_zip.output_base64sha256
    }
  ]
}

module "monitoring_module" {
  depends_on               = [module.compute_module]
  source                   = "./modules/monitoring_module"
  create_lambda_log_groups = [for lambda in module.compute_module.created_lambdas : lambda.function_name]
}

module "compute_module" {
  depends_on = [
    module.security_module,
    module.storage_module,
    module.network_module
  ]
  source = "./modules/compute_module"
  create_lambdas = [
    {
      function_name    = local.lambda_config.hello.function_name
      handler          = local.lambda_config.hello.handler
      runtime          = local.lambda_config.hello.runtime
      role_arn         = module.security_module.lambda_execution_role.arn
      s3_bucket_id     = module.storage_module.lambda-build-s3-bucket.id
      s3_key           = local.lambda_config.hello.build_bucket_key
      source_code_hash = data.archive_file.hello_zip.output_base64sha256
      vpc_config = {
        subnet_ids         = [module.network_module.pokedex_subnet.id]
        security_group_ids = [module.network_module.pokeapi_security_group.id]
      }
    }
  ]
}
