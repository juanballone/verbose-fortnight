resource "azurerm_virtual_network_peering" "runners" {
  name                      = "${var.runners_virtual_network_name}-to-${azurerm_virtual_network.vnet.name}"
  resource_group_name       = var.runners_resource_group_name
  virtual_network_name      = var.runners_virtual_network_name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_virtual_network_peering" "this" {
  name                      = "${azurerm_virtual_network.vnet.name}-to-${var.runners_virtual_network_name}"
  resource_group_name       = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = var.runners_virtual_network_id
}
