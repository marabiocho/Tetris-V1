# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Optional but recommended in production
    }
    vault = {
      source = "hashicorp/vault"
      # version = "~> 3.0"  # Optional but recommended in production
    }
  }
}

# AWS Provider Block
provider "aws" {
  region  = "us-west-2"  # Specify your region
  profile = "default"    # Use the 'default' AWS profile
}

# Vault Provider Block
provider "vault" {
  address = "http://192.168.56.41:8200"  # Replace with your Vault server address
  token   = "your-vault-token-here"      # Replace with your Vault token
}

# Example for fetching AWS credentials from Vault (optional)
data "vault_generic_secret" "aws_credentials" {
  path = "kv/data/aws/credentials"  # Correct path for Vault v2 secrets
}

provider "aws" {
  region     = data.vault_generic_secret.aws_credentials.data["region"]
  access_key = data.vault_generic_secret.aws_credentials.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_credentials.data["aws_secret_access_key"]
}
