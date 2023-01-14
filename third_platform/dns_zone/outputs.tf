# --- Outputs Section --- #

# ---------------------------------------------------------------- Outputs --- #

output "aws_route53_name_servers" {
  value       = aws_route53_zone.aws_zone.name_servers
  description = "NS Record of route53"
}

output "fqdn" {
  value       = "${var.subdomain_name}${var.domain_name}"
  description = "FQDN of the website"
}
