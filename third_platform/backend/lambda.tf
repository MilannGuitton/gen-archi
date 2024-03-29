# ------------------------------------------------------------------ Shell --- #

resource "null_resource" "build_lambda_layers" {

  provisioner "local-exec" {

    command = "cd ${path.module}/lambda && ./build.sh"
  }
}

# ----------------------------------------------------------------- Layers --- #

resource "aws_lambda_layer_version" "pymysql" {
  filename    = "${path.module}/lambda/packages/python3-pymysql.zip"
  layer_name  = "python3-pymysql"
  description = "Layer for pymysql python package"

  compatible_architectures = ["x86_64"]

  compatible_runtimes = ["python3.8"]

  source_code_hash = filebase64sha256("${path.module}/lambda/packages/python3-pymysql.zip")
}


# ------------------------------------------------------------------- Ping --- #

data "archive_file" "tcp_ping" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src/tcp_ping"
  output_path = "${path.module}/lambda/src/tcp_ping.zip"
}

resource "aws_lambda_function" "tcp_ping" {
  filename      = "${path.module}/lambda/src/tcp_ping.zip"
  function_name = "${var.project_name}-tcp_ping"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10

  depends_on = [aws_iam_role_policy_attachment.lambda_rds_access]

  source_code_hash = data.archive_file.tcp_ping.output_base64sha256

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [module.sg_lambda_mysql.security_group_id]
  }
}


# ----------------------------------------------------------------- Health --- #

data "archive_file" "health" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src/health"
  output_path = "${path.module}/lambda/src/health.zip"
}

resource "aws_lambda_function" "health" {
  filename      = "${path.module}/lambda/src/health.zip"
  function_name = "${var.project_name}-health"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  layers = [aws_lambda_layer_version.pymysql.arn]

  source_code_hash = data.archive_file.health.output_base64sha256

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [module.sg_lambda_mysql.security_group_id]
  }

  environment {
    variables = {
      DB_NAME     = var.db_name
      DB_PASSWORD = var.db_password
      DB_USERNAME = var.db_username
      DB_HOST     = module.db_spacelift_mysql.db_instance_address
    }
  }
}


# -------------------------------------------------------------------- Get --- #

data "archive_file" "get" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src/get"
  output_path = "${path.module}/lambda/src/get.zip"
}

resource "aws_lambda_function" "get" {
  filename      = "${path.module}/lambda/src/get.zip"
  function_name = "${var.project_name}-get"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  layers = [aws_lambda_layer_version.pymysql.arn]

  source_code_hash = data.archive_file.health.output_base64sha256

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [module.sg_lambda_mysql.security_group_id]
  }

  environment {
    variables = {
      DB_NAME     = var.db_name
      DB_PASSWORD = var.db_password
      DB_USERNAME = var.db_username
      DB_HOST     = module.db_spacelift_mysql.db_instance_address
    }
  }
}


# ------------------------------------------------------------------- Post --- #

data "archive_file" "post" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src/post"
  output_path = "${path.module}/lambda/src/post.zip"
}

resource "aws_lambda_function" "post" {
  filename      = "${path.module}/lambda/src/post.zip"
  function_name = "${var.project_name}-post"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  source_code_hash = data.archive_file.post.output_base64sha256

  layers = [aws_lambda_layer_version.pymysql.arn]

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [module.sg_lambda_mysql.security_group_id]
  }

  environment {
    variables = {
      DB_NAME     = var.db_name
      DB_PASSWORD = var.db_password
      DB_USERNAME = var.db_username
      DB_HOST     = module.db_spacelift_mysql.db_instance_address
    }
  }
}
