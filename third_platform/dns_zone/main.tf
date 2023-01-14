# --- Route53 Section --- #

# ------------------------------------------------------------------- Zone --- #

resource "aws_route53_zone" "aws_zone" {
  name = "${var.subdomain_name}${var.domain_name}"

  force_destroy = true

  tags = {
    Terraform = "true"
  }
}
