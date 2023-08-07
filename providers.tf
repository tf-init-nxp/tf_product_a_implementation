terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
  backend "azurerm" {
    use_oidc = false
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}
