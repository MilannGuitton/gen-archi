# -------------------------------------------------------- Records section --- #

# ---------------------------------------------- p2-backend.aws.tryhard.fr --- #

resource "aws_route53_record" "backend" {
  allow_overwrite = true
  name            = "p2-backend.aws.tryhard.fr"
  ttl             = 300
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.aws_tryhard_fr.zone_id

  records = [
    module.alb-backend.lb_dns_name,
  ]
}

# --------------------------------------------- p2-frontend.aws.tryhard.fr --- #

resource "aws_route53_record" "frontend" {
  allow_overwrite = true
  name            = "p2-frontend.aws.tryhard.fr"
  ttl             = 300
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.aws_tryhard_fr.zone_id

  records = [
    module.alb-frontend.lb_dns_name,
  ]
}


# --------------------------------------------- p2-database.aws.tryhard.fr --- #

resource "aws_route53_record" "database" {
  allow_overwrite = true
  name            = "p2-database.aws.tryhard.fr"
  ttl             = 300
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.aws_tryhard_fr.zone_id

  records = [
    module.nlb-database.lb_dns_name,
  ]
}