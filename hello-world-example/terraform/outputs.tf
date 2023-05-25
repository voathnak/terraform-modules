
output "hello-world-function-name" {
  description = "hello-world-function"

  value = module.hello_world_lambda.function_name
}


output "hello-world-function-arn" {
  description = "hello-world-function-arn"

  value = module.hello_world_lambda.arn
}


output "rootAPI" {
  description = "rootAPI"

  value = format("https://%s.execute-api.%s.amazonaws.com/%s",
    aws_api_gateway_rest_api.root_api.id,
    var.aws_region,
    aws_api_gateway_stage.stage.stage_name)
}

output "hello_world_lambda_endpoint" {
  description = "hello_world_lambda_endpoint"

  value = format("https://%s.execute-api.%s.amazonaws.com/%s/%s",
    aws_api_gateway_rest_api.root_api.id,
    var.aws_region,
    aws_api_gateway_stage.stage.stage_name,
    module.hello_world_gateway_resource.uri_path_part)
}
