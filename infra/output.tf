output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "eventhub_namespace" {
  value = azurerm_eventhub_namespace.ns.name
}

output "eventhub_name" {
  value = azurerm_eventhub.hub.name
}

output "connection_string" {
  value     = azurerm_eventhub_authorization_rule.access.primary_connection_string
  sensitive = true
}

output "storage_connection_string" {
  value     = azurerm_storage_account.checkpoint.primary_connection_string
  sensitive = true
}