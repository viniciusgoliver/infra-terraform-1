terraform {
  // Provider que iremos utilizar no nosso provisionamento de infra
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

// Configurações de Auth na AWS
provider "aws" {
  profile = "AWSPersonalVINI"
  region  = "us-east-1"
}
