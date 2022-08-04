# estou adicionando aproximadamente 19 recursos com esse terraform
terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/root/.aws/credentials"
}
