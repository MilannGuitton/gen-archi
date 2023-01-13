# ----------------------------------------------------------------- Locals --- #

locals {
  username = "admin"
  password = "tryhardpassword"
  endpoint = module.db.db_instance_endpoint

  tags = {
    Name        = "Spacelift_Test_RDS"
    Environment = "Spacelift_Test"
  }
}


# -------------------------------------------------------------------- Get --- #

data "archive_file" "zip_get" {
  type        = "zip"
  source_dir  = "${path.module}/python/get"
  output_path = "${path.module}/python/get.zip"
}

resource "aws_lambda_function" "terraform_lambda_get" {
  filename      = "${path.module}/python/get.zip"
  function_name = "lambda_function_get"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  environment {
    variables = {
      NAME     = local.name
      PASSWORD = local.password
      ENDPOINT = local.endpoint
    }
  }
}


# ------------------------------------------------------------------- Post --- #

data "archive_file" "zip_post" {
  type        = "zip"
  source_dir  = "${path.module}/python/post"
  output_path = "${path.module}/python/post.zip"
}

resource "aws_lambda_function" "terraform_lambda_post" {
  filename      = "${path.module}/python/post.zip"
  function_name = "lambda_function_post"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  environment {
    variables = {
      NAME     = local.name
      PASSWORD = local.password
      ENDPOINT = local.endpoint
    }
  }
}


# ------------------------------------------------------------------- Test --- #

data "archive_file" "zip_health" {
  type        = "zip"
  source_dir  = "${path.module}/python/health"
  output_path = "${path.module}/python/health.zip"
}

resource "aws_lambda_function" "terraform_lambda_health" {
  filename      = "${path.module}/python/health.zip"
  function_name = "lambda_function_health"
  role          = aws_iam_role.lambda_spacelift.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.lambda_rds_access]

  environment {
    variables = {
      NAME     = local.name
      PASSWORD = local.password
      ENDPOINT = local.endpoint
    }
  }
}
