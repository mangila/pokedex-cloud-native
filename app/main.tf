# data "aws_availability_zones" "available" {
#   state = "available"
# }

resource "aws_servicecatalogappregistry_application" "application_registry" {
  name = "pokedex-cloud-native"
}

resource "aws_cloudwatch_event_connection" "step-function-connection" {
  name               = "step-function-connection"
  description        = "A connection description"
  authorization_type = "BASIC"

  auth_parameters {
    basic {
      username = var.eventbridge_connection_user
      password = var.eventbridge_connection_password
    }
  }
}

resource "local_file" "step_function_1" {
  filename = "step_function_asl.json"
  content = jsonencode({
    Comment = "hello world"
    StartAt = "Hello"
    States = {
      Hello = {
        Type   = "Pass"
        Result = "Hello"
        Next   = "World"
      }
      World = {
        Type   = "Pass"
        Result = "World"
        End    = true
      }
    }
  })
}

module "step" {
  source                                 = "terraform-aws-modules/step-functions/aws"
  name                                   = "step1"
  cloudwatch_log_group_name              = "stepfunction/step1"
  cloudwatch_log_group_retention_in_days = 7
  type                                   = "express"
  logging_configuration = {
    include_execution_data = true
    level                  = "INFO"
  }
  service_integrations = {
    xray = {
      xray = true
    }
  }
  definition                = local_file.step_function_1.content
  cloudwatch_log_group_tags = aws_servicecatalogappregistry_application.application_registry.application_tag
  role_tags                 = aws_servicecatalogappregistry_application.application_registry.application_tag
  tags                      = aws_servicecatalogappregistry_application.application_registry.application_tag
}