resource "azurerm_kubernetes_cluster" "cluster" {
  dns_prefix = "wpakc"
  location = azurerm_resource_group.rg_wordpress.location
  name = "wp-akc"
  resource_group_name = azurerm_resource_group.rg_wordpress.name

  default_node_pool {
    name = "wpnodepool"
    vm_size = var.k8s_vm_size
    enable_auto_scaling = true
    min_count = 2
    max_count = 4
    node_count = 2
//    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  service_principal {
    client_id = var.azure_k8s_client
    client_secret = var.azure_k8s_client_secret
  }

  linux_profile {
    admin_username = "nimda"
    ssh_key {
      key_data = file(var.azure_kubernetes_admin_ssh_key)
    }
  }

  tags = {
    env = "test"
  }

}