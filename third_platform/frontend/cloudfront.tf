# --- Cloudfront Section --- #

# ----------------------------------------------------------------- Locals --- #

locals {
  s3_origin_id = "s3-cloudfront"
}


# ------------------------------------------------------------- Cloudfront --- #

resource "aws_cloudfront_distribution" "s3_website" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cloudfront_description
  default_root_object = var.default_document

  aliases = [aws_s3_bucket.website.id]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 3600
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  depends_on = [
    aws_s3_bucket.website,
    aws_acm_certificate_validation.cert_validation
  ]

  wait_for_deployment = false

  tags = {
    Terraform = "True"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-${var.zone_name}.s3.amazonaws.com"
}
