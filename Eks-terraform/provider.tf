# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 5.0" # Optional but recommended in production
    }
    vault = {
      source = "hashicorp/vault"
      # version = "~> 3.0" # Optional but recommended in production
    }
  }
}

# Vault Provider Block
provider "vault" {
  address = "http://192.168.56.41:8200"
  token   = "hvs.FOb6crKNmuJHVGfZtVXARioG"
}

# Data Source to Fetch AWS Credentials from Vault
data "vault_generic_secret" "aws_credentials" {
  path = "kv/data/aws/credentials" # Correct path for Vault v2 secrets
}

provider "aws" {
  region     = data.vault_generic_secret.aws_credentials.data["region"]
  access_key = data.vault_generic_secret.aws_credentials.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_credentials.data["aws_secret_access_key"]
}
