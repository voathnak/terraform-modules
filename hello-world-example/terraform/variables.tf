variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name"

  type    = string
  default = "sample-hello-world-serverless"
}
