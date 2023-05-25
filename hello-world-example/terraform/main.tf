module "hello_world_lambda" {
  source = "git::https://github.com/voathnak/terraform-modules.git//quick_lambda?ref=v1.0.0.1"

  project_name = var.project_name
  aws_region   = var.aws_region

  name        = "hello_world"
  source_file = "../services/hello_world/handler.py"

}

module "hello_world_gateway_resource" {
  source = "git::https://github.com/voathnak/terraform-modules.git//rest_api_gateway_resource?ref=v1.0.0.1"

  parent_id         = aws_api_gateway_rest_api.root_api.root_resource_id
  authorization     = "NONE"
  http_methods      = ["GET", "POST", "PUT", "DELETE"]
  path_part         = "hello"
  resource_specific = false
  rest_api          = aws_api_gateway_rest_api.root_api
  function          = module.hello_world_lambda.function
}
