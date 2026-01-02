output "s3_resume_url" {
  value = "https://${aws_s3_bucket.s3.bucket}.s3.amazonaws.com/${var.key_file}"
}



