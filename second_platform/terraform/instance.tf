# ------------------------------------------------------ Instances section --- #

locals {
  image_id           = "ami-0493936afbe820b28"
  instance_type      = "t2.micro"
  front_ip           = "10.0.0.10"
  back_ip            = "10.0.0.20"
  db_ip              = "10.0.0.30"
  monitor_ip         = "10.0.0.40"
  user_data_ssh_keys = <<EOF
#cloud-config
disable_root: false
ssh_authorized_keys:
  - ${aws_key_pair.kp_alexis_boissiere.public_key}
  - ${aws_key_pair.kp_milann_guitton.public_key}
  - ${aws_key_pair.kp_clement_dailly.public_key}
  - ${aws_key_pair.kp_benoit_gornet.public_key}
  - ${aws_key_pair.kp_aymeric_olivaux.public_key}
  - ${aws_key_pair.kp_liann_pelhate.public_key}
# Update apt database on first boot
package_update: true
# Upgrade the instance on first boot
package_upgrade: true
EOF
}


# --------------------------------------------------------------- Frontend --- #

resource "aws_instance" "frontend" {
  ami           = local.image_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.kp_sigl_admin.key_name
  user_data     = local.user_data_ssh_keys

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
  user_data     = local.user_data_ssh_keys

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
  user_data     = local.user_data_ssh_keys

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
  user_data     = local.user_data_ssh_keys

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