# ------------------------------------------------------------------ Mysql --- #

module "db_spacelift_mysql" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.db_name

  create_db_option_group    = false
  create_db_parameter_group = false

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage = 20

  db_name                = var.db_name
  username               = var.db_username
  create_random_password = false
  password               = var.db_password
  port                   = 3306

  db_subnet_group_name = module.vpc.database_subnet_group

  vpc_security_group_ids = [module.sg_mysql.security_group_id]

  maintenance_window = null
  backup_window      = null

  backup_retention_period = 0

  skip_final_snapshot = true
}
