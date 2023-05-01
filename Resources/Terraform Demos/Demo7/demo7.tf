
locals {
  suffix = "tfdemo"
  location = "westeurope"
}

variable "vmCount" {
  type = number
  default = 0
}

variable "vmSku" {
  type = string
  default = "Standard_A4_v2"
  validation {
    condition = var.vmSku == "Standard_A4_v2" || var.vmSku == "Standard_A2_v2"
    error_message = "The vmSku must be one of the following: Standard_A4_v2 or Standard_A2_v2"
  }
}

variable "kvId" {
  type = string
  description = "id for the keyvault holding secrets"
}

variable "userNameSecret" {
  type = string
  default = "DefaultAdminUsername"
}

variable "passwordSecret" {
  type = string
  default = "DefaultAdminPassword"
}

data "azurerm_key_vault_secret" "userName" {
  name         = var.userNameSecret
  key_vault_id = var.kvId
}

data "azurerm_key_vault_secret" "password" {
  name         = var.passwordSecret
  key_vault_id = var.kvId
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${local.suffix}"
  location = local.location
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name  = azurerm_resource_group.example.name
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-${count.index}"
  allocation_method   = "Dynamic"
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  count = var.vmCount

}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  count = var.vmCount
  ip_configuration {
    name                          = "private"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "vm-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = local.location
  size                = var.vmSku
  admin_username      = data.azurerm_key_vault_secret.userName.value
  admin_password      = data.azurerm_key_vault_secret.password.value
  count               = var.vmCount
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
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

resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg1"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
