locals {
  username = "admin"
  password = "tryhardpassword"
  endpoint = module.db.db_instance_endpoint

  tags = {
    Name        = "Spacelift_Test_RDS"
    Environment = "Spacelift_Test"
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "Spacelift_Test_Lambda_Function_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_get" {
  type        = "zip"
  source_dir  = "${path.module}/python/get"
  output_path = "${path.module}/python/get.zip"
}

data "archive_file" "zip_post" {
  type        = "zip"
  source_dir  = "${path.module}/python/post"
  output_path = "${path.module}/python/post.zip"
}

resource "aws_lambda_function" "terraform_lambda_get" {
filename                       = "${path.module}/python/get.zip"
function_name                  = "lambda_function_get"
role                           = aws_iam_role.lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

  environment {
    variables = {
      NAME = local.name
      PASSWORD = local.password
      ENDPOINT = local.endpoint
    }
  }
}

resource "aws_lambda_function" "terraform_lambda_post" {
filename                       = "${path.module}/python/post.zip"
function_name                  = "lambda_function_post"
role                           = aws_iam_role.lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

  environment {
    variables = {
      NAME = local.name
      PASSWORD = local.password
      ENDPOINT = local.endpoint
    }
  }
}

