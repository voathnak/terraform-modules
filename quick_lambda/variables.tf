variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name"

  type = string
}

variable "name" {
  description = "function name"

  type = string
}

variable "full_name" {
  description = "function full_name"

  type = string
  default = ""
}

variable "handler" {
  description = "function handler"

  type    = string
  default = "handler.lambda_handler"
}

variable "runtime" {
  description = "function runtime"

  type    = string
  default = "python3.8"
}

variable "source_file" {
  description = "function source_file"

  type = string
}

variable "source_code_hash" {
  description = "function source_code_hash"

  type = string
  default = ""
}

variable "layers_arn" {
  description = "list of layer arn"

  type    = list(string)
  default = []
}

variable "environment_variables" {
  description = "environment_variables"

  type    = object({})
  default = {}
}
