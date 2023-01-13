resource "aws_route53_record" "genarchi_post" {
  name    = aws_apigatewayv2_domain_name.genarchi.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.aws_zone.zone_id

  alias {
    name                   = aws_apigatewayv2_domain_name.genarchi.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.genarchi.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}
