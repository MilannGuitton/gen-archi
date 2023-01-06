# ------------------------------------------------------------ ALB section --- #

# -------------------------------------------------------------------- ALB --- #

module "alb-frontend" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "alb-frontend"

  load_balancer_type = "application"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  security_groups = [aws_security_group.allow_all.id]

  target_groups = [
    {
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        front-1 = {
          target_id = aws_instance.frontend[0].id
          port      = 80
        }
        front-2 = {
          target_id = aws_instance.frontend[1].id
          port      = 80
        }
        front-3 = {
          target_id = aws_instance.frontend[2].id
          port      = 80
        }
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = data.aws_acm_certificate.cert.id
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}