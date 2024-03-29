# -------------------------------------------------------------------- ACM --- #

resource "aws_acm_certificate" "cert_backend_p3" {
  domain_name = "backend.${var.subdomain_name}${var.domain_name}"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Terraform = "True"
  }
}

resource "aws_route53_record" "backend_p3_dns_cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert_backend_p3.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert_backend_p3.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert_backend_p3.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.aws_zone.id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "backend_p3_cert_validation" {
  certificate_arn         = aws_acm_certificate.cert_backend_p3.arn
  validation_record_fqdns = [aws_route53_record.backend_p3_dns_cert_validation.fqdn]
}
