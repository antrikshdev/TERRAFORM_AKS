terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
/*   backend "azurerm" {
    subscription_id      = "acef6dd4-ca96-44bd-a2f4-a32161fe4d38"
    resource_group_name  = "rg-tfstate-kada"
    storage_account_name = "satfstatekada"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  } */

}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}