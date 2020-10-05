/**
Since provider has moved to linode/linode for users on Terraform 0.13 or greater,
I have used linode/linode instead of hashicorp/linode in required_providers.
**/
terraform {
  required_version = "0.12.21"  
  required_providers {
    linode = {
      version = ">= 1.13"
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.token
}