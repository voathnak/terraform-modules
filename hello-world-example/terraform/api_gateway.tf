resource "aws_api_gateway_rest_api" "root_api" {
  name = "private-chat-gpt-dev-root-api"
}

resource "aws_api_gateway_deployment" "root_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.root_api.id
  triggers = {
    redeployment = sha1(jsonencode([
      module.hello_world_gateway_resource.deployment_sha,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.root_api_deployment.id
  rest_api_id = aws_api_gateway_rest_api.root_api.id
  stage_name = "dev"
}
