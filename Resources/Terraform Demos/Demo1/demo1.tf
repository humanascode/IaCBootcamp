resource "azurerm_resource_group" "rgtest" {
  name     = "rganame"
  location = "westeurope"
  tags = {
    "Env" = "Dev"
  }
}

resource "azurerm_storage_account" "sademo" {
  name = "saname"
  location = "westeurope"
  resource_group_name = azurerm_resource_group.rgtest.name
  account_tier = "Standard"
  account_replication_type = "LRS"
}