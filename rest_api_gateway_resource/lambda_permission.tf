locals {
  resource_path_name = replace(replace(aws_api_gateway_resource.api_resource.path_part, "{", "-"), "}", "-")
#  resource_path_name = replace(aws_api_gateway_resource.api_resource.path, "/", "-")
  execution_arn      = var.rest_api.execution_arn
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  for_each = toset(var.http_methods)

#  statement_id  = "${var.rest_api.name}Allow${each.key}Invoke"
  statement_id  = format("%sAllow%s%sInvoke", var.rest_api.name, local.resource_path_name, each.key)
  action        = "lambda:InvokeFunction"
  function_name = var.function.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${local.execution_arn}/*/${each.key}${aws_api_gateway_resource.api_resource.path}"

}

resource "aws_lambda_permission" "apigw_resource_specific_lambda_permission" {
  count = var.resource_specific ? length(var.resource_specific_http_methods) : 0

  statement_id  = format("%sAllow-Specific-Id-%sInvoke", var.rest_api.name, var.resource_specific_http_methods[count.index])
  action        = "lambda:InvokeFunction"
  function_name = var.function.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${local.execution_arn}/*/${var.resource_specific_http_methods[count.index]}${aws_api_gateway_resource.api_resource_specific[0].path}"
  depends_on = [aws_api_gateway_resource.api_resource_specific]
}
