output "lambda-build-s3-bucket" {
  value = aws_s3_bucket.lambda-build-s3-bucket
}

output "created_lambda_archive_s3_objects" {
  value = aws_s3_object.created_lambda_archive_s3_objects
}