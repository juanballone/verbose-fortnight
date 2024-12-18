resource "azurerm_public_ip" "bas" {
  count               = var.enable_bastion ? 1 : 0
  name                = "pip-bas-${azurerm_resource_group.rg.location}-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bas" {
  count               = var.enable_bastion ? 1 : 0
  name                = "bas-pvaks-${azurerm_resource_group.rg.location}-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bas[0].id
  }
}
