
terraform {
  required_version = ">= 1.0.7"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.0.0"
      configuration_aliases = [aws.us-east-1]
    }
  }
}
