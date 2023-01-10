# --------------------------------------------------- Certificates section --- #

# ------------------------------------------------------------------ Certs --- #

data "aws_acm_certificate" "cert" {
  domain    = "p2-backend.aws.tryhard.fr"
  statuses  = ["ISSUED"]
  key_types = ["RSA_2048"]
}