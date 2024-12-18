terraform {
  backend "azurerm" {}
}

data "terraform_remote_state" "runners" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.remote_state_rg_name
    storage_account_name = var.remote_state_storage_account
    container_name       = var.remote_state_container
    key                  = var.remote_state_key
  }
}
