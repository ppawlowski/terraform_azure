resource "azurerm_storage_account" "storage" {
  account_replication_type = "ZRS"
  account_tier = "Standard"
  location = azurerm_resource_group.rg_wordpress.location
  name = "demowpsharedstorage"
  resource_group_name = azurerm_resource_group.rg_wordpress.name
}

resource "azurerm_storage_share" "storage_share" {
  name = "wpcontent"
  storage_account_name = azurerm_storage_account.storage.name
}