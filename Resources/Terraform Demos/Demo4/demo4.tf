resource "azurerm_resource_group" "example" {
  name     = "rg-tfworkshop-demo"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.example.name
  location            = "westeurope"
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name  = azurerm_resource_group.example.name
}

resource "azurerm_public_ip" "pip1" {
  name                = "pip1"
  allocation_method   = "Dynamic"
  resource_group_name = azurerm_resource_group.example.name
  location            = "westeurope"

}

resource "azurerm_network_interface" "nic1" {
  name                = "nic1"
  resource_group_name = azurerm_resource_group.example.name
  location            = "westeurope"
  ip_configuration {
    name                          = "private"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm1"
  resource_group_name = azurerm_resource_group.example.name
  location            = "westeurope"
  size                = "Standard_A4_v2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
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