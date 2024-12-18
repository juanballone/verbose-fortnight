resource "azurerm_network_interface" "nic" {
  count               = var.enable_vm ? 1 : 0
  name                = "nic-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.global.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "random_password" "vm1" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-+=?"
  upper            = true
  lower            = true
}

resource "azurerm_windows_virtual_machine" "vm1" {
  count               = var.enable_vm ? 1 : 0
  name                = "vm-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"
  admin_password      = random_password.vm1.result
  network_interface_ids = [
    azurerm_network_interface.nic[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-ent"
    version   = "latest"

    # x64             windows-11              MicrosoftWindowsDesktop  win11-23h2-ent               MicrosoftWindowsDesktop:windows-11:win11-23h2-ent:22631.3447.240406                   22631.3447.240406
  }
}
