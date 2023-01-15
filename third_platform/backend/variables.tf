# ------------------------------------------------------------------- Main --- #

variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}


# -------------------------------------------------------------------- DNS --- #

variable "domain_name" {
  type = string
}

variable "subdomain_name" {
  type = string
}


# ------------------------------------------------------------------- VPC --- #

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "vpc_azs" {
  type = list(string)
}


# --------------------------------------------------------------------- DB --- #

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type    = string
  default = "tryhardpassword"
}
