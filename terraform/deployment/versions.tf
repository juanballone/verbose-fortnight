terraform {
  required_version = ">= 1.9.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1" # Replace with the latest version if necessary
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2" # Replace with the latest version if necessary
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4" # Replace with the latest version if necessary
    }
  }
}
