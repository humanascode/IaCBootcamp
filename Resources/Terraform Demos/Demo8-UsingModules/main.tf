
resource "azurerm_resource_group" "example" {
  name     = var.rgName
  location = local.location
}


resource "azurerm_public_ip" "pip1" {
  name                = "${local.publicIpName}-${count.index}}"
  allocation_method   = local.publicIpAllocation
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  count               = var.vmCount

}

resource "azurerm_network_interface" "nic1" {
  name                = "${local.nicName}-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  ip_configuration {
    name                          = "private"
    subnet_id                     = module.net.subnetId
    private_ip_address_allocation = local.privateIpAllocation
    public_ip_address_id          = azurerm_public_ip.pip1[count.index].id
  }
  count = var.vmCount
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "${var.vmName}-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  size                = var.vmSku
  admin_username      = data.azurerm_key_vault_secret.userName.value
  admin_password      = data.azurerm_key_vault_secret.password.value
  count               = var.vmCount
  network_interface_ids = [
    azurerm_network_interface.nic1[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

module "net" {
  source = "./Modules/Networking"
  rgName = azurerm_resource_group.example.name
  nsgName = "nsg123"
  location = azurerm_resource_group.example.location
  vnetAddressSpace = local.vnetAddressSpace
  subnetAddressSpace = local.subnetAddressSpace
  vnetName = "vnet123"
  subnetName = "subnet123"
}