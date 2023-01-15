# --- Tfvars Section --- #

# -------------------------------------------------------------- Variables --- #

aws_region   = "eu-west-3"
project_name = "spacelift"

domain_name    = "aws.tryhard.fr"
subdomain_name = "backend.p3."

vpc_name = "sigl-spacelift-p3"
vpc_azs  = ["eu-west-3a", "eu-west-3b"]

db_name     = "spacelift"
db_username = "mariondb"
