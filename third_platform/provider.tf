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
    key     = "genarchi/common.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}

provider "aws" {
  alias  = "default"
  region = var.aws_region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

