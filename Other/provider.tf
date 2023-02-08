terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.30.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dev"
  region = "eu-west-3"
  assume_role {
    role_arn = "arn:aws:iam::257305051220:role/terraform_role"
  }
}