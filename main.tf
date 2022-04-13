resource "azurerm_resource_group" "myRGDb" {
  name     = "myRGDb"
  location = "East US 2"
}

resource "azurerm_sql_server" "sqlserver2808" {
  name                         = "sqlserver2808"
  resource_group_name          = azurerm_resource_group.myRGDb.name
  location                     = "East US 2"
  version                      = "12.0"
  administrator_login          = "sqluser"
  administrator_login_password = "Pa $$ w0rd1234"
}

resource "azurerm_sql_database" "db1" {
  name                = "db1"
  resource_group_name = azurerm_resource_group.myRGDb.name
  location            = "East US 2"
  server_name         = azurerm_sql_server.sqlserver2808.name

  depends_on = [
    azurerm_sql_server.sqlserver2808
  ]
}

resource "azurerm_sql_firewall_rule" "firewall_rule" {
  name                = "firewall_rule"
  resource_group_name = azurerm_resource_group.myRGDb.name
  server_name         = azurerm_sql_server.sqlserver2808.name
  start_ip_address    = "181.51.32.98"
  end_ip_address      = "181.51.32.98"

  depends_on = [
    azurerm_sql_server.sqlserver2808
  ]
}
