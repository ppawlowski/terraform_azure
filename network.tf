resource "azurerm_virtual_network" "aks_network" {
  name = "aks-network"
  location = azurerm_resource_group.rg_wordpress.location
  resource_group_name = azurerm_resource_group.rg_wordpress.name
  address_space = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "aks_subnet" {
  name = "aks-subnet"
  address_prefix = "10.0.0.0/24"
  resource_group_name = azurerm_resource_group.rg_wordpress.name
  virtual_network_name = azurerm_virtual_network.aks_network.name
}