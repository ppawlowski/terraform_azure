resource azurerm_resource_group "rg_wordpress" {
  location = "West Europe"
  name = "wordpress_resources"
}

resource "azurerm_resource_group" "rg_db" {
  location = "France Central"
  name = "database_resources"
}