resource "azurerm_kubernetes_cluster" "aks" {
  name                       = "aks-pvaks-${azurerm_resource_group.rg.location}-001"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  dns_prefix_private_cluster = "aks-pvaks-${azurerm_resource_group.rg.location}-001"
  private_cluster_enabled    = true
  private_dns_zone_id        = var.aks_private_dns_zone_id
  workload_identity_enabled  = true
  oidc_issuer_enabled        = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  default_node_pool {
    name           = "agentpool"
    node_count     = 3
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks.id
    max_pods       = 30 # Number of pods per node
    upgrade_settings {
      max_surge = "25%"
    }
  }

  network_profile {
    network_plugin = "azure" # Azure CNI
    service_cidr   = "10.250.0.0/16"
    dns_service_ip = "10.250.0.10"
  }

  dynamic "oms_agent" {
    for_each = var.enable_azure_monitoring ? [1] : []
    content {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics[0].id
    }
  }

  depends_on = [
    azurerm_role_assignment.network_contributor,
    azurerm_role_assignment.dns_contributor
  ]
}

### Identity
resource "azurerm_user_assigned_identity" "aks" {
  name                = "id-aks-${azurerm_resource_group.rg.location}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_user_assigned_identity" "pod" {
  name                = "id-pod-${azurerm_resource_group.rg.location}-001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

### Identity role assignment
resource "azurerm_role_assignment" "private_dns_contributor" {
  scope                = var.aks_private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_role_assignment" "dns_contributor" {
  scope                = var.environment_public_dns_zone_id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_role_assignment" "kubelet_dns_contributor" {
  scope                = var.environment_public_dns_zone_id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_role_assignment" "monitoring" {
  count                = var.enable_azure_monitoring ? 1 : 0
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.aks.oms_agent[0].oms_agent_identity[0].object_id
}

resource "azurerm_role_assignment" "cluster_acr_pull" {
  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
