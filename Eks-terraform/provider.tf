# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    vault = {
      source = "hashicorp/vault"
    }
  }
}

# Vault Provider Block
provider "vault" {
  address = "http://192.168.56.41:8200"  # Replace with your Vault server address
  token   = "your-vault-token-here"      # Replace with your Vault token
}

# AWS Provider Block (using Vault credentials)
provider "aws" {
  region     = "us-west-2"  # Specify your region
  access_key = data.vault_generic_secret.aws_credentials.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_credentials.data["aws_secret_access_key"]
}

# Example Vault Data Source for AWS credentials
data "vault_generic_secret" "aws_credentials" {
  path = "kv/data/aws/credentials"  # Replace with your correct Vault path
}
