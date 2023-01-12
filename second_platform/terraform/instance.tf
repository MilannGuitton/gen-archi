# ------------------------------------------------------ Instances section --- #

# --------------------------------------------------------- Locals section --- #

locals {
  image_id           = "ami-0493936afbe820b28"
  instance_type      = "t2.micro"
  front_ips          = ["10.0.0.10", "10.0.32.10", "10.0.64.10"]
  back_ips           = ["10.0.0.20", "10.0.32.20", "10.0.64.20"]
  db_ips             = ["10.0.16.30", "10.0.48.30", "10.0.80.30"]
  monitor_ip         = "10.0.0.40"
  frontend_user_data = file("./user_data/frontend.yml")
  bastion_user_data  = file("./user_data/bastion.yml")
  db_user_data      = file("./user_data/database.yml")
  backend_user_data = file("./user_data/backend.yml")

}


# ---------------------------------------------------------------- Bastion --- #

resource "aws_instance" "bastion" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.bastion_user_data

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Bastion",
    Terraform = "true"
  }
}


# --------------------------------------------------------------- Frontend --- #

resource "aws_instance" "frontend" {
  count         = 3
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.frontend_user_data

  subnet_id  = module.vpc.public_subnets[count.index]
  private_ip = local.front_ips[count.index]

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Frontend-${count.index + 1}",
    Terraform = "true"
  }
}


# ---------------------------------------------------------------- Backend --- #

resource "aws_instance" "backend" {
  count         = 3
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.backend_user_data

  subnet_id  = module.vpc.public_subnets[count.index]
  private_ip = local.back_ips[count.index]

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  tags = {
    Name      = "Backend-${count.index + 1}",
    Terraform = "true"
  }
}


# --------------------------------------------------------------- Database --- #

resource "aws_instance" "database" {
  count         = 3
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.db_user_data

  subnet_id  = module.vpc.private_subnets[count.index]
  private_ip = local.db_ips[count.index]

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  root_block_device {
    volume_size = 10
    delete_on_termination = true
  }

  tags = {
    Name      = "Database-${count.index + 1}",
    Terraform = "true"
  }
}