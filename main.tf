terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"   # any recent 3.x is fine
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # leave this false (or omit) until the RPs are registered
  # skip_provider_registration = true

 # helm = {
    #   source = "hashicorp/helm"
    #   version = "~> 2.11.0"
    # }
}
