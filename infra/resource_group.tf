resource "azurerm_resource_group" "rg" {
  #   name     = "rg-eh-dev"
  name     = "rg-eh-${var.env}"
  location = var.location

  tags = {
    env   = var.env
    owner = var.owner
    app   = "eventhub-platform"
  }
}
