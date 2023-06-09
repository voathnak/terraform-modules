terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "ap-southeast-1"
  shared_credentials_files = ["/Users/vlim/.aws/credentials"]
  profile                  = "aws2-vlim"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project_name
    }
  }
}
