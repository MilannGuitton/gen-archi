# ----------------------------------------------------------------- Output --- #

output "db_instance_status" {
  description = "The RDS instance status"
  value       = module.db_spacelift_mysql.db_instance_status
}

output "backend_url" {
  value = "https://${aws_apigatewayv2_api_mapping.genarchi.domain_name}"
}
