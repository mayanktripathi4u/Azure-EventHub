resource "azurerm_eventhub_namespace" "ns" {
  name                = "eh-ns-${var.env}-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku      = "Standard"
  capacity = 1

  auto_inflate_enabled     = true
  maximum_throughput_units = 5

  tags = azurerm_resource_group.rg.tags
}


resource "azurerm_eventhub" "hub" {
  name         = "app-logs"
  namespace_id = azurerm_eventhub_namespace.ns.id

  partition_count   = 2
  message_retention = 1
}

resource "azurerm_eventhub_authorization_rule" "access" {
  name                = "app-access"
  namespace_name      = azurerm_eventhub_namespace.ns.name
  eventhub_name       = azurerm_eventhub.hub.name
  resource_group_name = azurerm_resource_group.rg.name

  listen = true
  send   = true
  manage = false
}

resource "random_id" "suffix" {
  byte_length = 4
}
