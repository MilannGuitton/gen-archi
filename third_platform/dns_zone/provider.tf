# --- Provider Section --- #

# -------------------------------------------------------------- Terraform --- #
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }

  backend "s3" {
    bucket  = "tryhard-tf-infra"
    key     = "genarchi/dns_zone/common.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}

# Default Region
provider "aws" {
  region = var.aws_region
}
