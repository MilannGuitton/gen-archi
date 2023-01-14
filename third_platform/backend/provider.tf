terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45"
    }
  }

  backend "s3" {
    bucket  = "tryhard-tf-infra"
    key     = "genarchi/rds/common.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}

provider "aws" {
  region = local.region
}
