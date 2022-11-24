# ------------------------------------------------------ Instances section --- #

locals {
  image_id          = "ami-0493936afbe820b28"
  instance_type     = "t2.micro"
  front_ip          = "10.0.0.10"
  back_ip           = "10.0.0.20"
  db_ip             = "10.0.0.30"
  monitor_ip        = "10.0.0.40"
  frontend_user_data  = file("./frontend-cloud-init.yml")
  db_user_data      = file("./db-cloud-init.yml")
  backend_user_data = file("./backend-cloud-init.yml")
  monitor_user_data = file("./monitor-cloud-init.yml")
}


# --------------------------------------------------------------- Frontend --- #

resource "aws_instance" "frontend" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.frontend_user_data

  subnet_id  = module.vpc.public_subnets[0]
  private_ip = local.front_ip

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Frontend",
    Terraform = "true"
  }
}


# ---------------------------------------------------------------- Backend --- #

resource "aws_instance" "backend" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.backend_user_data

  subnet_id  = module.vpc.public_subnets[0]
  private_ip = local.back_ip

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Backend",
    Terraform = "true"
  }
}


# --------------------------------------------------------------- Database --- #

resource "aws_instance" "db" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.db_user_data

  subnet_id  = module.vpc.public_subnets[0]
  private_ip = local.db_ip

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "DB",
    Terraform = "true"
  }
}


# ---------------------------------------------------------------- Monitor --- #

resource "aws_instance" "monitor" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.monitor_user_data

  subnet_id  = module.vpc.public_subnets[0]
  private_ip = local.monitor_ip

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Monitor",
    Terraform = "true"
  }
}