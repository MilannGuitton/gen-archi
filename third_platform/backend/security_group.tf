# ----------------------------------------------------------------- Lambda --- #

module "sg_lambda_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "lambda-mysql"
  description = "Lambda for MySQL"
  vpc_id      = module.vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      description = "MySQL egress access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]
}


# ------------------------------------------------------------------ MySQL --- #

module "sg_db_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.db_name}-db"
  description = "MySQL from lambda"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "TCP"
      description              = "MySQL ingress access from lambda"
      source_security_group_id = module.sg_lambda_mysql.security_group_id
    },
  ]

  egress_with_source_security_group_id = [
    {
      from_port                = 0
      to_port                  = 0
      protocol                 = "TCP"
      description              = "Allow egress TCP to lambda"
      source_security_group_id = module.sg_lambda_mysql.security_group_id
    }
  ]
}
