# --- Main Section --- #

# ------------------------------------------------------------------- Data --- #

data "aws_route53_zone" "public_zone" {
  name = "${var.zone_name}."
}
