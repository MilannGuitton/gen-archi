# ------------------------------------------------------------------- Role --- #

resource "aws_iam_role" "lambda_spacelift" {
  name               = "lambda_function_spacelift"
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


# --------------------------------------------------------------- Policies --- #

data "aws_iam_policy" "rds_full_access" {
  name = "AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_rds_access" {
  role       = aws_iam_role.lambda_spacelift.name
  policy_arn = data.aws_iam_policy.rds_full_access.arn
}

data "aws_iam_policy" "lambda_vpc_access" {
  name = "AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {
  role       = aws_iam_role.lambda_spacelift.name
  policy_arn = data.aws_iam_policy.lambda_vpc_access.arn
}
