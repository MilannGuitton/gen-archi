# ------------------------------------------------------------------ Mysql --- #

module "sg_lambda_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "Lambda mysql sg"
  description = "MySQL security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all inbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "sg_db_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.db_name
  description = "MySQL security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all inbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
    #{
    #from_port   = 3306
    #to_port     = 3306
    #protocol    = "tcp"
    #description = "MySQL access from within VPC"
      #cidr_blocks = module.vpc.vpc_cidr_block
      #cidr_blocks = "0.0.0.0/0"
      #},
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
