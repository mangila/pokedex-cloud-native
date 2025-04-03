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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                                                      = "pokedex_vpc"
  default_vpc_enable_dns_hostnames                          = true
  default_vpc_enable_dns_support                            = true
  cidr                                                      = "10.0.0.0/16"
  azs                                                       = var.aws_azs
  private_subnets                                           = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets                                            = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_enable_resource_name_dns_a_record_on_launch = true
  enable_nat_gateway                                        = true
  single_nat_gateway                                        = true
  nat_gateway_destination_cidr_block                        = "0.0.0.0/0"
  default_security_group_egress = [
    {
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "generation" {
  source        = "./modules/lambda_module"
  function_name = "generation"
  timeout       = 6
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]
  s3_bucket_id = aws_s3_bucket.lambda-build-s3-bucket.id
  archive_file = {
    type        = "zip"
    source_file = "lambda_src/generation/bootstrap"
    output_path = "generation-lambda.zip"
  }
  vpc_subnet_ids         = module.vpc.private_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]
}
