output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "username" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].username
}

output "password" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].password
}

output "client_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
}

output "client_key" {
  value = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
}

output "cluster_ca_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "kubelet_identity_client_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
}
