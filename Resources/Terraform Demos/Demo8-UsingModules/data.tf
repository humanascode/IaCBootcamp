

data "azurerm_key_vault_secret" "userName" {
  name         = var.userNameSecret
  key_vault_id = var.kvId
}

data "azurerm_key_vault_secret" "password" {
  name         = var.passwordSecret
  key_vault_id = var.kvId
}