variable "parent_id" {
  type = string
  description = "aws_api_gateway_rest_api resource_id"
}
variable "path_part" {
  type = string
  description = "api endpoint path"
}
variable "authorization" {
  type = string
  description = "api-gateway authorization"
}

variable "http_methods" {
  type = list(string)

  default = ["GET"]

  validation {
    condition     = length(var.http_methods) > 0
    error_message = "The http_method value must contain at least 1 http method string."
  }
}

variable "resource_specific_http_methods" {
  type = list(string)

  default = ["GET", "PUT", "DELETE"]
  description = "the specific method (/id) for the specify http-method"

  validation {
    condition     = length(var.resource_specific_http_methods) > 0
    error_message = "The http_method value must contain at least 1 http method string."
  }

}

variable "resource_specific" {
  type = bool

  default = false
  description = "add {id} to resources"
}

variable "function" {
  type = object({
    function_name = string
    invoke_arn    = string
  })
}
variable "rest_api" {
  type = object({
    name          = string
    id            = string
    execution_arn = string
  })
}
