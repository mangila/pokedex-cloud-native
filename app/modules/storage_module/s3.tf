resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "aws_s3_bucket" "lambda-build-s3-bucket" {
  bucket = format("pokedex-lambda-build-bucket-%s", random_string.random.result)
}

resource "aws_s3_object" "created_lambda_archive_s3_objects" {
  count = length(var.create_lambda_archive_s3_objects)

  bucket      = aws_s3_bucket.lambda-build-s3-bucket.id
  key         = var.create_lambda_archive_s3_objects[count.index].key
  source      = var.create_lambda_archive_s3_objects[count.index].source
  source_hash = var.create_lambda_archive_s3_objects[count.index].source_hash
}