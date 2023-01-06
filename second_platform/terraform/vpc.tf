# ------------------------------------------------------------ VPC section --- #

# --------------------------------------------------------- Locals section --- #

locals {
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
  vpc_azs     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}


# -------------------------------------------------------------------- VPC --- #

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-tryhard"
  cidr = local.vpc_cidr

  azs = local.vpc_azs

  public_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 0),
    cidrsubnet(local.vpc_cidr, 4, 2),
    cidrsubnet(local.vpc_cidr, 4, 4),
  ]

  private_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 1),
    cidrsubnet(local.vpc_cidr, 4, 3),
    cidrsubnet(local.vpc_cidr, 4, 5),
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = true

  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
  }
}
