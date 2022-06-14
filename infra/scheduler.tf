resource "aws_cloudwatch_event_rule" "dbt-scheduler" {
  name                = "dbt-scheduler"
  description         = "Trigger for lambda that executes DBT"
  schedule_expression = "cron(*/5 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "dbt-lambda-target" {
  rule      = aws_cloudwatch_event_rule.dbt-scheduler.name
  target_id = "lambda"
  arn       = aws_lambda_function.dbt_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dbt_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.dbt-scheduler.arn
}