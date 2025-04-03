resource "aws_iam_policy" "sqs_send_msg_policy" {
  name        = "lambda_sqs_policy"
  description = "Policy for Lambda to send messages to SQS"
  policy = jsonencode({
    Version = "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sqs:SendMessage",
        "Resource" : "*"
      }
    ]
  })
}