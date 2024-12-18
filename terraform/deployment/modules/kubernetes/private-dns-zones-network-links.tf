resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  resource_group_name   = var.runners_resource_group_name
  name                  = azurerm_virtual_network.vnet.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  private_dns_zone_name = var.aks_private_dns_zone_name
  tags                  = var.tags
}

# TODO: Fix as it is causing issues with resolving DNS names
# resource "azurerm_private_dns_zone_virtual_network_link" "environment" {
#   resource_group_name   = var.runners_resource_group_name
#   name                  = azurerm_virtual_network.vnet.name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
#   private_dns_zone_name = var.environment_private_dns_zone_name
#   tags                  = var.tags
# }
