resource "aws_iam_policy" "step-function-pokeapi" {
  name        = "step-function-pokeapi"
  description = "IAM policy for a Step Function to invoke PokeAPI HTTP requests"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "states:InvokeHTTPEndpoint",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "states:HTTPMethod" : "GET"
          },
          "StringLike" : {
            "states:HTTPEndpoint" : [
              "https://pokeapi.co/api/v2/**",
              "https://raw.githubusercontent.com/PokeAPI/**"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "events:RetrieveConnectionCredentials"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource" : "arn:aws:secretsmanager:*:*:secret:events!connection/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "states:StartExecution",
          "states:DescribeExecution",
          "states:StopExecution",
          "states:GetExecutionHistory"
        ]
        "Resource" : "*"
      }
    ]
  })
}