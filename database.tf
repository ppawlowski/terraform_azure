resource "azurerm_mariadb_server" "wp_db_srv" {
  name = var.database_server_prefix
  location = azurerm_resource_group.rg_db.location
  resource_group_name = azurerm_resource_group.rg_db.name
  administrator_login = var.database_admin_username
  administrator_login_password = var.database_admin_password
  ssl_enforcement = "Disabled"
  version = "10.2"
  sku_name = "B_Gen5_2"
  storage_profile {
    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"
    auto_grow = "Disabled"
  }
}

resource "azurerm_mariadb_database" "wp_db" {
  name = "wordpress"
  resource_group_name = azurerm_resource_group.rg_db.name
  server_name = azurerm_mariadb_server.wp_db_srv.name
  charset = "utf8"
  collation = "utf8_general_ci"
}

resource "azurerm_mariadb_firewall_rule" "wp_db_fw_home" {
  for_each = toset(var.database_allowed_ips)
  name = "${replace(each.key, ".", "")}-access"
  server_name = azurerm_mariadb_server.wp_db_srv.name
  resource_group_name = azurerm_mariadb_server.wp_db_srv.resource_group_name
  start_ip_address = each.key
  end_ip_address = each.key
}

resource "mysql_user" "wp_db_user" {
  user = "wp_user"
  plaintext_password = var.database_password
  host = "%"
}

resource "mysql_grant" "wp_db_user_grant" {
  database = "wordpress"
  user = mysql_user.wp_db_user.user
  host = mysql_user.wp_db_user.host
  privileges = ["ALL"]
}