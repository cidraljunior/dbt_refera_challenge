
variable "project_version" {}

resource "aws_lambda_function" "dbt_lambda" {
  architectures = ["x86_64"]

  ephemeral_storage {
    size = "512"
  }

  function_name                  = "dbt_lambda_exec"
  image_uri                      = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/dbt_refera_challenge:${var.project_version}"
  memory_size                    = "512"
  package_type                   = "Image"
  reserved_concurrent_executions = "-1"
  role                           = aws_iam_role.dbt-lambda-role.arn
  timeout                        = "600"

  tracing_config {
    mode = "PassThrough"
  }
}
