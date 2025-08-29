terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group_storage" {
  source  = "app.terraform.io/zave52/resource_group_storage/azurerm"
  version = "1.0.1"

  resource_group_name  = "my-rg"
  location             = "East US"
  storage_account_name = "mystorageaccount123"
}