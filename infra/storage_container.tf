resource "azurerm_storage_container" "checkpoint" {
  name                  = "eh-checkpoints"
#   storage_account_name  = azurerm_storage_account.checkpoint.name
  storage_account_id     = azurerm_storage_account.checkpoint.id
  container_access_type = "private"
}