# --- Main Section --- #

# ------------------------------------------------------------------- Data --- #

data "aws_route53_zone" "aws_zone" {
  name = "${var.domain_name}."
}