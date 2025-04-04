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

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#
#   name                                                      = "pokedex_vpc"
#   default_vpc_enable_dns_hostnames                          = true
#   default_vpc_enable_dns_support                            = true
#   cidr                                                      = "10.0.0.0/16"
#   azs                                                       = var.aws_azs
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#   public_subnet_enable_resource_name_dns_a_record_on_launch = true
#   enable_nat_gateway                                        = true
#   single_nat_gateway                                        = true
#   nat_gateway_destination_cidr_block                        = "0.0.0.0/0"
#   default_security_group_egress = [
#     {
#       protocol    = -1
#       cidr_blocks = "0.0.0.0/0"
#     }
#   ]
# }

module "s3_bucket_for_lambda_source_code" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  bucket_prefix = "pokedex-lambda-build-bucket-"
  force_destroy = true
}

module "enrich_pokemon" {
  source = "./modules/lambda_module"

  function_name = "enrich-pokemon"
  timeout       = 10
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    aws_iam_policy.sqs_send_msg_policy.arn
  ]
  s3_bucket_id = module.s3_bucket_for_lambda_source_code.s3_bucket_id
  archive_file = {
    type        = "zip"
    source_file = "lambda_src/enrich_pokemon/bootstrap"
    output_path = "enrich-pokemon-lambda.zip"
  }
  environment_variables = {
  }
}

module "fetch_generation" {
  source = "./modules/lambda_module"

  function_name = "fetch-generation"
  timeout       = 10
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    aws_iam_policy.sqs_send_msg_policy.arn
  ]
  s3_bucket_id = module.s3_bucket_for_lambda_source_code.s3_bucket_id
  archive_file = {
    type        = "zip"
    source_file = "lambda_src/fetch_generation/bootstrap"
    output_path = "fetch-generation-lambda.zip"
  }
  environment_variables = {
    GENERATION_QUEUE_URL : module.pokemon_sqs.queue_url
  }
}

module "persist_pokemon" {
  source = "./modules/lambda_module"

  function_name = "persist-pokemon"
  timeout       = 10
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    aws_iam_policy.sqs_send_msg_policy.arn
  ]
  s3_bucket_id = module.s3_bucket_for_lambda_source_code.s3_bucket_id
  archive_file = {
    type        = "zip"
    source_file = "lambda_src/persist_pokemon/bootstrap"
    output_path = "persist-pokemon-lambda.zip"
  }
  environment_variables = {
  }
}

module "pokemon_sqs" {
  source = "terraform-aws-modules/sqs/aws"

  name                       = "pokemon-q"
  visibility_timeout_seconds = 120
  delay_seconds              = 10
  receive_wait_time_seconds  = 20
  message_retention_seconds  = 60 * 3600

  redrive_policy = {
    maxReceiveCount = 3
  }

  create_dlq                     = true
  dlq_name                       = "pokemon-dlq"
  dlq_visibility_timeout_seconds = 120
  dlq_receive_wait_time_seconds  = 20
  dlq_message_retention_seconds  = 60 * 3600
}