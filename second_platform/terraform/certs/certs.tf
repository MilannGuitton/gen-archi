# --------------------------------------------------- Certificates section --- #

# ------------------------------------------------------------------ Certs --- #

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = "p2.aws.tryhard.fr"
  zone_id      = data.aws_route53_zone.aws_tryhard_fr.zone_id

  subject_alternative_names = [
    "backend.p2.aws.tryhard.fr",
  ]

  wait_for_validation = false

  tags = {
    Name = "p2.aws.tryhard.fr"
  }
}