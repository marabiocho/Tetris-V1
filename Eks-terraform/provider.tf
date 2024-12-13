# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      source = "hashicorp/aws"
      # version = "~> 5.0" # Optional but recommended in production
    }
    vault = {
      source = "hashicorp/vault"
      # version = "~> 3.0" # Optional but recommended in production
    }
  }
}
