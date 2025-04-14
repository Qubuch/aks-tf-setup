terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate65412132435724354"
    container_name       = "terraformbackend"
    key                  = "terraform.tfstate"
  }
}
