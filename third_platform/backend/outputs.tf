# Default
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.db_spacelift_mysql.db_instance_address
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = module.db_spacelift_mysql.db_instance_status
}

output "db_instance_name" {
  description = "The database name"
  value       = module.db_spacelift_mysql.db_instance_name
}

output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.default.invoke_url
}

output "custom_domain_api" {
  value = "https://${aws_apigatewayv2_api_mapping.genarchi.domain_name}"
}
