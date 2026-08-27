output "s3_bucket_name" {
  description = "Name of the S3 website bucket."
  value       = aws_s3_bucket.static_site.bucket
}

output "s3_website_endpoint" {
  description = "S3 static website endpoint."
  value       = aws_s3_bucket_website_configuration.static_site.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront domain serving the static website."
  value       = "https://${aws_cloudfront_distribution.static_site.domain_name}"
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.static_site.id
}
