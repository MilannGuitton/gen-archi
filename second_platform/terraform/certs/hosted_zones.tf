# --------------------------------------------------- Hosted zones section --- #

# --------------------------------------------------------- aws.tryhard.fr --- #

data "aws_route53_zone" "aws_tryhard_fr" {
  name = "aws.tryhard.fr"
}