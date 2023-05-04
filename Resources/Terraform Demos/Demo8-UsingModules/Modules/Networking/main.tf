

variable "vnetName" {
  type = string
}

variable "vnetAddressSpace" {
  type = list(string)
}

variable "rgName" {
  type = string
}

variable "location" {
  type = string
}

variable "subnetName" {
  type = string
}

variable "subnetAddressSpace" {
  type = list(string)
}

variable "nsgName" {
    type = string
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetName
  address_space       = var.vnetAddressSpace
  resource_group_name = var.rgName
  location            = var.location
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnetName
  address_prefixes     = var.subnetAddressSpace
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name  = var.rgName
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsgName
  location            = var.location
  resource_group_name = var.rgName
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

output "subnetId" {
  value = azurerm_subnet.subnet1.id
}