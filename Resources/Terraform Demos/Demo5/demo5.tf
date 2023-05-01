terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3" # ~>  =
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-****"
    storage_account_name = "tfstate122"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}