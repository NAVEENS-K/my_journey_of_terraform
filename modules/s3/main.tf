resource "aws_s3_bucket" "s3" {
    bucket = var.bucket_name
}
resource "aws_s3_object" "resume" {
  bucket = aws_s3_bucket.s3.id
  key = var.key_file
  source = var.resume_file_path
  content_type = var.content_type
  etag = filemd5(var.resume_file_path)
}
