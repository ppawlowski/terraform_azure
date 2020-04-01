resource "azurerm_container_registry" "acr" {
  for_each = toset(var.acr_list)
  name = each.key
  location = azurerm_resource_group.rg_wordpress.location
  resource_group_name = azurerm_resource_group.rg_wordpress.name
  sku = "Basic"
}