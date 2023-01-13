# --- ACM Section --- #

# ------------------------------------------------------------- get --- #

# This creates an SSL certificate
resource "aws_acm_certificate" "cert_get" {
  domain_name = "get.${var.subdomain_name}${var.domain_name}"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Terraform = "True"
  }
}

# This is a DNS record for the ACM certificate validation to prove we own the domain
resource "aws_route53_record" "get_dns_cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert_get.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert_get.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert_get.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.aws_zone.id
  ttl             = 60
}

# This tells terraform to cause the route53 validation to happen
resource "aws_acm_certificate_validation" "get_cert_validation" {
  certificate_arn         = aws_acm_certificate.cert_get.arn
  validation_record_fqdns = [aws_route53_record.get_dns_cert_validation.fqdn]
}


# ------------------------------------------------------------- post --- #

# This creates an SSL certificate
resource "aws_acm_certificate" "cert_post" {
  domain_name = "post.${var.subdomain_name}${var.domain_name}"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Terraform = "True"
  }
}

# This is a DNS record for the ACM certificate validation to prove we own the domain
resource "aws_route53_record" "post_dns_cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert_post.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert_post.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert_post.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.aws_zone.id
  ttl             = 60
}

# This tells terraform to cause the route53 validation to happen
resource "aws_acm_certificate_validation" "post_cert_validation" {
  certificate_arn         = aws_acm_certificate.cert_post.arn
  validation_record_fqdns = [aws_route53_record.post_dns_cert_validation.fqdn]
}
