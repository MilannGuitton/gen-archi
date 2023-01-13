# -------------------------------------------------- Loadbalancers section --- #

# ----------------------------------------------------------- Frontend ALB --- #

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
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
      }
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


# ------------------------------------------------------------ Backend ALB --- #

module "alb-backend" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "alb-backend"

  load_balancer_type = "application"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  security_groups = [aws_security_group.allow_all.id]

  target_groups = [
    {
      backend_protocol = "HTTP"
      backend_port     = 8000
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/health"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
      }
      targets = {
        back-1 = {
          target_id = aws_instance.backend[0].id
          port      = 8000
        }
        back-2 = {
          target_id = aws_instance.backend[1].id
          port      = 8000
        }
        back-3 = {
          target_id = aws_instance.backend[2].id
          port      = 8000
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


# ----------------------------------------------------------- Database NLB --- #

module "nlb-database" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "nlb-database"

  load_balancer_type = "network"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  target_groups = [
    {
      backend_protocol = "TCP"
      backend_port     = 3306
      target_type      = "instance"
      targets = {
        db-1 = {
          target_id = aws_instance.database[0].id
          port      = 3306
        }
        db-2 = {
          target_id = aws_instance.database[1].id
          port      = 3306
        }
        db-3 = {
          target_id = aws_instance.database[2].id
          port      = 3306
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]
}