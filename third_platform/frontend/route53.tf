# --- Route53 Section --- #

# ---------------------------------------------------------------- Records --- #

resource "aws_route53_record" "s3_website" {
  zone_id = data.aws_route53_zone.public_zone.zone_id
  name    = "${var.website_prefix}${var.zone_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_website.domain_name
    zone_id                = aws_cloudfront_distribution.s3_website.hosted_zone_id
    evaluate_target_health = true
  }
}
