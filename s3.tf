locals {
  create_s3_object = (
    !(var.s3_bucket == null || var.s3_key == null || var.output_path == null)
  )
}

resource "aws_s3_object" "this" {
  count = local.create_s3_object ? 1 : 0

  bucket = var.s3_bucket
  key    = var.s3_key
  source = var.output_path

  etag = filemd5(var.output_path)
}
