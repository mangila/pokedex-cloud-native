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

module "fetch_generation" {
  source = "./modules/lambda_module"

  function_name = "fetch-generation"
  timeout       = 30
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    aws_iam_policy.sqs_send_msg_policy.arn
  ]
  s3_bucket_id = aws_s3_bucket.lambda-build-s3-bucket.id
  archive_file = {
    type        = "zip"
    source_file = "lambda_src/fetch_generation/bootstrap"
    output_path = "fetch-generation-lambda.zip"
  }
  environment_variables = {
    GENERATION_QUEUE_URL : module.generation_queue.queue_url
  }
}

module "generation_queue" {
  source = "terraform-aws-modules/sqs/aws"

  name                       = "generation-queue"
  visibility_timeout_seconds = 120
  delay_seconds              = 10
  receive_wait_time_seconds  = 20
  message_retention_seconds  = 60 * 3600

  redrive_policy = {
    maxReceiveCount = 3
  }

  create_dlq                     = true
  dlq_name                       = "generation-dead-queue"
  dlq_visibility_timeout_seconds = 120
  dlq_receive_wait_time_seconds  = 20
  dlq_message_retention_seconds  = 60 * 3600
}
