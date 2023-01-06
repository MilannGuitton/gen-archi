# ------------------------------------------------------ Instances section --- #

# --------------------------------------------------------- Locals section --- #

locals {
  image_id           = "ami-0493936afbe820b28"
  instance_type      = "t2.micro"
  front_ips          = ["10.0.0.10", "10.0.32.10", "10.0.64.10"]
  frontend_user_data = file("./frontend-cloud-init.yml")
  bastion_user_data  = file("./bastion-cloud-init.yml")

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
    Name      = "Frontend-${count.index}",
    Terraform = "true"
  }
}