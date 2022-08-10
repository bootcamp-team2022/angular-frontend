output "s3_web_addr" {
    value = aws_s3_bucket.web_enabled_bucket.website_endpoint
}