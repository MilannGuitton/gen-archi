# --- Variables Section --- #

# -------------------------------------------------------------- Variables --- #

variable "aws_region" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "website_prefix" {
  type = string
}

variable "default_document" {
  type    = string
  default = "index.html"
}

variable "cloudfront_description" {
  type    = string
  default = "Static Site"
}
