# ------------------------------------------------------------ VPC Section --- #

# --------------------------------------------------------- Locals Section --- #

locals {
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
  vpc_azs     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}


# -------------------------------------------------------------------- VPC --- #

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-SIGL"
  cidr = local.vpc_cidr

  azs = local.vpc_azs

  public_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 0),
    cidrsubnet(local.vpc_cidr, 4, 2),
    cidrsubnet(local.vpc_cidr, 4, 4),
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
  }
}
