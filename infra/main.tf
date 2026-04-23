terraform {
  required_version = ">=1.5"

  cloud {
    organization = "rambabu-cloud-lab"

    workspaces {
      name = "azure-dev"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = false
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-hcp-demo"
  location = "Australia East"
}

resource "azurerm_storage_account" "st" {
  name                     = "ramst${random_string.rand.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_string" "rand" {
  length  = 6
  special = false
  upper   = false
}
# HCP Terraform VCS trigger test