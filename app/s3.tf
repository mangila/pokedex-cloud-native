resource "aws_s3_bucket" "pokedex_lambda_bucket" {
  bucket = format("pokedex-lambda-bucket-%s", random_string.random_string_generator.result)
}

resource "aws_s3_object" "hello_s3_object" {
  bucket      = aws_s3_bucket.pokedex_lambda_bucket.id
  key         = "hello-bootstrap.zip"
  source      = data.archive_file.hello_zip.output_path
  source_hash = data.archive_file.hello_zip.output_base64sha256
}