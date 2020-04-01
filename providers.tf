provider azurerm {
  version = "=2.3.0"
  features {}
}

provider "kubernetes" {
  load_config_file = false
  host = azurerm_kubernetes_cluster.cluster.kube_config.0.host
  username = azurerm_kubernetes_cluster.cluster.kube_config.0.username
  password = azurerm_kubernetes_cluster.cluster.kube_config.0.password
  client_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
}

provider "mysql" {
  endpoint = "${azurerm_mariadb_server.wp_db_srv.fqdn}:3306"
  username = "${var.database_admin_username}@${var.database_server_prefix}"
  password = var.database_admin_password
}