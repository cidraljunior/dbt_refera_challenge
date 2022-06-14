data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}


data "aws_iam_policy_document" "lambda-execution-policy" {
  statement {
    actions = [
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:StartQueryExecution"
    ]
    resources = ["arn:aws:athena:${local.region}:${local.account_id}:workgroup/*"]
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["arn:aws:kms:${local.region}:${local.account_id}:key/*"]
  }
  statement {
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${local.region}:${local.account_id}:log-group:*"]
  }
  statement {
    actions = [
      "s3:*",
      "glue:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "dbt-lambda-role" {
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json

  inline_policy {
    name   = "LambdaExecutionPolicy"
    policy = data.aws_iam_policy_document.lambda-execution-policy.json
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  max_session_duration = "3600"
  name                 = "dbt-lambda-role"
  path                 = "/"
}
