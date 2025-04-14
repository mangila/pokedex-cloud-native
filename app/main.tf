resource "aws_servicecatalogappregistry_application" "application_registry" {
  name = "pokedex-cloud-native"
}

resource "aws_cloudwatch_event_connection" "step-function-connection" {
  name               = "step-function-connection"
  description        = "Eventbridge connection for the step function to invoke HTTP requests"
  authorization_type = "BASIC"

  auth_parameters {
    basic {
      username = var.eventbridge_connection_user
      password = var.eventbridge_connection_password
    }
  }
}

module "pokemon-state-machine" {
  source  = "terraform-aws-modules/step-functions/aws"
  version = "4.2.1"
  name    = "pokemon-state-machine"
  definition = templatefile("templates/pokemon-state-machine.json", {
    ConnectionArn : aws_cloudwatch_event_connection.step-function-connection.arn
  })
  attach_policy = true
  policy        = aws_iam_policy.step-function-pokeapi.arn
  role_tags     = aws_servicecatalogappregistry_application.application_registry.application_tag

  cloudwatch_log_group_name              = "stepfunction/pokemon-state-machine"
  cloudwatch_log_group_retention_in_days = 7
  cloudwatch_log_group_tags              = aws_servicecatalogappregistry_application.application_registry.application_tag
  logging_configuration = {
    include_execution_data = true
    level                  = "ALL"
  }
  service_integrations = {
    xray = {
      xray = true
    }
  }

  tags = aws_servicecatalogappregistry_application.application_registry.application_tag
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.20.2"

  function_name = "asdf"
  description   = "My awesome lambda function"
  handler       = "bootstrap"
  runtime       = "provided.al2023"

  attach_policies = true
  policies = [

  ]
  role_tags = aws_servicecatalogappregistry_application.application_registry.application_tag

  source_path = "./lambda/fetch-pokemon-variety"

  cloudwatch_logs_retention_in_days = 7
  cloudwatch_logs_tags              = aws_servicecatalogappregistry_application.application_registry.application_tag

  tags = aws_servicecatalogappregistry_application.application_registry.application_tag
}