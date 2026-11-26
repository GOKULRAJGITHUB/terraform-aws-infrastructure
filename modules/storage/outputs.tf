output "s3_bucket_name" {
  value = aws_s3_bucket.resume_storage.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.resume_storage.arn
}
