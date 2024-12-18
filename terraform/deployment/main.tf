module "main" {
  source                         = "./modules/kubernetes"
  aks_private_dns_zone_id        = data.terraform_remote_state.runners.outputs.aks_private_dns_zone_id
  aks_private_dns_zone_name      = data.terraform_remote_state.runners.outputs.aks_private_dns_zone_name
  environment_public_dns_zone_id = data.azurerm_dns_zone.environment.id
  runners_resource_group_name    = data.terraform_remote_state.runners.outputs.resource_group_name
  runners_virtual_network_name   = data.terraform_remote_state.runners.outputs.virtual_network_name
  runners_virtual_network_id     = data.terraform_remote_state.runners.outputs.virtual_network_id
  container_registry_id          = data.azurerm_container_registry.acr.id
}

data "azurerm_dns_zone" "environment" {
  name                = "dev.argentoriver.com"
  resource_group_name = "rg-azure-devops"
}

data "azurerm_container_registry" "acr" {
  name                = "acrautomaticfortnight"
  resource_group_name = "rg-global-deploy"
}

data "azurerm_client_config" "current" {}

module "kubernetes_baseline" {
  source              = "../modules/kubernetes-baseline-configuration"
  resource_group_name = data.azurerm_dns_zone.environment.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subscription_id     = data.azurerm_client_config.current.subscription_id
  domain_filter       = data.azurerm_dns_zone.environment.name
  identity_client_id  = module.main.kubelet_identity_client_id
  depends_on          = [module.main]
}
