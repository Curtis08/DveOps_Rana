dynamic "azurerm_storage_account" {
    for_each = var.azurerm_storage_account != null ? [1] : []
    content {
  name                     = var.azurerm_storage_account.name
  resource_group_name      = var.azurerm_storage_account.resource_group.name
  location                 = var.azurerm_storage_account.location
  account_tier             = var.azurerm_storage_account.account_tier
  account_replication_type = var.azurerm_storage_account.account_replication_type

    }
}
