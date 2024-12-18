resource "azurerm_log_analytics_workspace" "log_analytics" {
  count                      = var.enable_azure_monitoring ? 1 : 0
  name                       = "myLogAnalyticsWorkspace"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  sku                        = "PerGB2018"
  retention_in_days          = 30
  internet_ingestion_enabled = false
  internet_query_enabled     = false
  tags                       = var.tags
}

resource "azurerm_application_insights" "app_insights" {
  count                         = var.enable_azure_monitoring ? 1 : 0
  name                          = "myAppInsights"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  local_authentication_disabled = true
  internet_ingestion_enabled    = false
  internet_query_enabled        = false
  workspace_id                  = azurerm_log_analytics_workspace.log_analytics[0].id
  application_type              = "web"
  tags                          = var.tags
}

resource "azurerm_monitor_private_link_scope" "ampls" {
  count               = var.enable_azure_monitoring ? 1 : 0
  name                = "ampls"
  resource_group_name = azurerm_resource_group.rg.name
  #   ingestion_access_mode = "PrivateOnly"
  #   query_access_mode     = "PrivateOnly"
  tags = var.tags
}

resource "azurerm_monitor_private_link_scoped_service" "amplsservice_app_insights" {
  count               = var.enable_azure_monitoring ? 1 : 0
  name                = "${azurerm_application_insights.app_insights[0].name}-amplsservice"
  resource_group_name = azurerm_resource_group.rg.name
  scope_name          = azurerm_monitor_private_link_scope.ampls[0].name
  linked_resource_id  = azurerm_application_insights.app_insights[0].id
}

resource "azurerm_monitor_private_link_scoped_service" "amplsservice_log_analytics" {
  count               = var.enable_azure_monitoring ? 1 : 0
  name                = "${azurerm_log_analytics_workspace.log_analytics[0].name}-amplsservice"
  resource_group_name = azurerm_resource_group.rg.name
  scope_name          = azurerm_monitor_private_link_scope.ampls[0].name
  linked_resource_id  = azurerm_log_analytics_workspace.log_analytics[0].id
}

resource "azurerm_private_endpoint" "ampls" {
  count               = var.enable_azure_monitoring ? 1 : 0
  name                = "ampls-private-endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.monitor.id

  private_service_connection {
    name                           = "privateserviceconnection"
    private_connection_resource_id = azurerm_monitor_private_link_scope.ampls[0].id
    subresource_names              = ["azuremonitor"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = var.ampls_private_dns_zone_ids
  }

}
