# ROLES LAMBDAS

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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


// POLICIES LAMBDAS
resource "aws_iam_policy" "fn_lambdas_logging" {
  name        = "fn-lambdas-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

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

# fn-api1

resource "aws_iam_role_policy_attachment" "fn_api1_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_lambdas_logging.arn
}

resource "aws_iam_policy" "fn_api1_policies" {
  name        = "fn_api1_policies"
  path        = "/"
  description = "IAM policies for API1 lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*",
        "S3:GetObject",
        "S3:PutObject"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF  
}

resource "aws_iam_role_policy_attachment" "fn_api1_policies_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_api1_policies.arn
}

data "archive_file" "fn_api1_file" {
  type        = "zip"
  output_path = "/tmp/fn_api1.zip"

  source {
    content  = <<EOF
      exports.handler = async (event, context) => {
        return {
          statusCode: 200,
          body: JSON.stringify('init lambda Auth Users')
        }
      }
    EOF
    filename = "fn-api1.js"
  }
}

variable "fn_api1_name" {
  default = "fn-api1"
}

resource "aws_lambda_function" "fn_api1" {
  filename      = data.archive_file.fn_api1_file.output_path
  function_name = var.fn_api1_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "fn-api1.handler"
  timeout       = 5
  memory_size   = 128

  runtime = "nodejs14.x"

  depends_on = [
    aws_iam_role_policy_attachment.fn_api1_logs,
    aws_cloudwatch_log_group.fn_api1_log_group,
  ]
}

resource "aws_cloudwatch_log_group" "fn_api1_log_group" {
  name              = "/aws/lambda/${var.fn_api1_name}"
  retention_in_days = 5
}


# fn-api2

resource "aws_iam_role_policy_attachment" "fn_api2_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_lambdas_logging.arn
}

resource "aws_iam_policy" "fn_api2_policies" {
  name        = "fn_api2_policies"
  path        = "/"
  description = "IAM policies for API2 lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*",
        "S3:GetObject",
        "S3:PutObject"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF  
}

resource "aws_iam_role_policy_attachment" "fn_api2_policies_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_api2_policies.arn
}

data "archive_file" "fn_api2_file" {
  type        = "zip"
  output_path = "/tmp/api2.zip"

  source {
    content  = <<EOF
      exports.handler = async (event, context) => {
        return {
          statusCode: 200,
          body: JSON.stringify('init lambda Metas Globais')
        }
      }
    EOF
    filename = "fn-api2.js"
  }
}

variable "fn_api2_name" {
  default = "fn-api2"
}

resource "aws_lambda_function" "fn_api2" {
  filename      = data.archive_file.fn_api2_file.output_path
  function_name = var.fn_api2_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "fn-api2.handler"
  timeout       = 5
  memory_size   = 128

  runtime = "nodejs14.x"

  depends_on = [
    aws_iam_role_policy_attachment.fn_api2_logs,
    aws_cloudwatch_log_group.fn_api2_log_group,
  ]
}

resource "aws_cloudwatch_log_group" "fn_api2_log_group" {
  name              = "/aws/lambda/${var.fn_api2_name}"
  retention_in_days = 5
}

# fn-api3

resource "aws_iam_role_policy_attachment" "fn_api3_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_lambdas_logging.arn
}

resource "aws_iam_policy" "fn_api3_policies" {
  name        = "fn_metas_setoriais_policies"
  path        = "/"
  description = "IAM policies for API3 lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*",
        "S3:GetObject",
        "S3:PutObject"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF  
}

resource "aws_iam_role_policy_attachment" "fn_api3_policies_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.fn_api3_policies.arn
}

data "archive_file" "fn_api3_file" {
  type        = "zip"
  output_path = "/tmp/api3.zip"

  source {
    content  = <<EOF
      exports.handler = async (event, context) => {
        return {
          statusCode: 200,
          body: JSON.stringify('init lambda Metas Setoriais')
        }
      }
    EOF
    filename = "fn-api3.js"
  }
}

variable "fn_api3_name" {
  default = "fn-api3"
}

resource "aws_lambda_function" "fn_api3" {
  filename      = data.archive_file.fn_api3_file.output_path
  function_name = var.fn_api3_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "fn-api3.handler"
  timeout       = 5
  memory_size   = 128

  runtime = "nodejs14.x"

  depends_on = [
    aws_iam_role_policy_attachment.fn_api3_logs,
    aws_cloudwatch_log_group.fn_api3_log_group,
  ]
}

resource "aws_cloudwatch_log_group" "fn_api3_log_group" {
  name              = "/aws/lambda/${var.fn_api3_name}"
  retention_in_days = 5
}
