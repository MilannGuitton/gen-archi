# --- Outputs Section --- #

# ---------------------------------------------------------------- Outputs --- #

output "cloudfront_distribution_status" {
  value       = aws_cloudfront_distribution.s3_website.status
  description = "Status of the cloudfront distribution"
}

output "website_fqdn" {
  value       = aws_route53_record.s3_website.fqdn
  description = "FQDN of the website"
}
