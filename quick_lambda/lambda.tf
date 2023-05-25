locals {
  name            = var.name
  lambda_zip_path = format("outputs/%s_lambda.zip", var.name)
  function_name   = length(var.full_name) > 0 ? var.full_name : format("%s-%s-%s", var.project_name, terraform.workspace, var.name)
  handler         = var.handler
  runtime         = var.runtime
}

data "archive_file" "this_lambda_archive" {
  type        = "zip"
  source_file = var.source_file
  output_path = local.lambda_zip_path
}


resource "aws_lambda_function" "this_lambda_function" {
  filename      = local.lambda_zip_path
  function_name = local.function_name
  role          = aws_iam_role.quick_set_lambda_role.arn
  handler       = local.handler
  runtime       = local.runtime
  timeout       = 300

  tags = {
    service       = var.project_name
    function_name = local.function_name
  }

  layers = var.layers_arn

  source_code_hash = var.source_code_hash

  environment {
    variables = var.environment_variables
  }
}

resource "aws_cloudwatch_log_group" "chat_gpt" {
  name = "/aws/lambda/${local.function_name}"

  retention_in_days = 7
}
