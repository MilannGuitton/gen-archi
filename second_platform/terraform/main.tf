# ----------------------------------------------------------- Main section --- #

terraform {
  required_version = ">= 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
  }

  backend "s3" {
    bucket = "terraform-tfstate-gen-archi"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = "eu-west-3"
}