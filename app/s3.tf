resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "aws_s3_bucket" "lambda-build-s3-bucket" {
  bucket = format("pokedex-lambda-build-bucket-%s", random_string.random.result)
}