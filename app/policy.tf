resource "aws_iam_policy" "step-function-http-invoke" {
  name = "step-function-http-invoke"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "states:InvokeHTTPEndpoint",
        "Resource" : "*"
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
      }
    ]
  })
}