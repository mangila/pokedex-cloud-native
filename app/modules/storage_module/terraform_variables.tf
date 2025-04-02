variable "create_lambda_archive_s3_objects" {
  description = "Lambda archives bucket s3 objects"
  type = list(object({
    key         = string
    source      = string
    source_hash = string
  }))
}