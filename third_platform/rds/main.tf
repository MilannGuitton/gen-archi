locals {
  name   = "mariondb"
  region = "eu-west-3"
}

################################################################################
# RDS Module
################################################################################

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.name}"

  create_db_option_group    = false
  create_db_parameter_group = false

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage = 20

  db_name  = local.name
  username = local.username
  create_random_password = false
  password = local.password
  port     = 3306

  db_subnet_group_name   = module.vpc.database_subnet_group

  vpc_security_group_ids = [module.security_group.security_group_id]


  maintenance_window = null
  backup_window      = null

  backup_retention_period = 0

  tags = local.tags
}


################################################################################
# Supporting Resources
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

    # egress
  egress_with_cidr_blocks = [
    {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    description      = "Allow all outbound traffic"
    cidr_blocks      = "0.0.0.0/0"
    }
  ]

  tags = local.tags
}
