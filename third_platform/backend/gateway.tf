# ------------------------------------------------------------ API Gateway --- #

resource "aws_apigatewayv2_api" "genarchi" {
  name          = "genarchi"
  description   = "API for genarchi p3"
  protocol_type = "HTTP"
  cors_configuration {

    allow_headers  = ["*"]
    allow_methods  = ["*"]
    allow_origins  = ["*"]
    expose_headers = ["*"]
    max_age        = 0
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.genarchi.id

  name        = "$default"
  auto_deploy = true
}


# ------------------------------------------------------------- Permission --- #

resource "aws_lambda_permission" "api_gw_tcp_ping" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tcp_ping.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.genarchi.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gw_health" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.health.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.genarchi.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gw_get" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.genarchi.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gw_post" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.genarchi.execution_arn}/*/*"
}


# ------------------------------------------------------------ Integration --- #

resource "aws_apigatewayv2_integration" "lambda_tcp_ping" {
  api_id = aws_apigatewayv2_api.genarchi.id

  integration_uri    = aws_lambda_function.tcp_ping.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_integration" "lambda_health" {
  api_id = aws_apigatewayv2_api.genarchi.id

  integration_uri    = aws_lambda_function.health.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_integration" "lambda_get" {
  api_id = aws_apigatewayv2_api.genarchi.id

  integration_uri    = aws_lambda_function.get.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_integration" "lambda_post" {
  api_id = aws_apigatewayv2_api.genarchi.id

  integration_uri    = aws_lambda_function.post.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}


# ----------------------------------------------------------------- Routes --- #

resource "aws_apigatewayv2_route" "get_tcp_ping" {
  api_id = aws_apigatewayv2_api.genarchi.id

  route_key = "GET /tcp_ping"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_tcp_ping.id}"
}

resource "aws_apigatewayv2_route" "get_health" {
  api_id = aws_apigatewayv2_api.genarchi.id

  route_key = "GET /health"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_health.id}"
}

resource "aws_apigatewayv2_route" "get_root" {
  api_id = aws_apigatewayv2_api.genarchi.id

  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_get.id}"
}

resource "aws_apigatewayv2_route" "post_root" {
  api_id = aws_apigatewayv2_api.genarchi.id

  route_key = "POST /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_post.id}"
}


# ------------------------------------------------------------ Domain name --- #

resource "aws_apigatewayv2_domain_name" "genarchi" {
  domain_name = "backend.${var.subdomain_name}${var.domain_name}"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert_backend_p3.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  depends_on = [aws_acm_certificate_validation.backend_p3_cert_validation]
}

resource "aws_apigatewayv2_api_mapping" "genarchi" {
  api_id      = aws_apigatewayv2_api.genarchi.id
  domain_name = aws_apigatewayv2_domain_name.genarchi.id
  stage       = aws_apigatewayv2_stage.default.id
}
