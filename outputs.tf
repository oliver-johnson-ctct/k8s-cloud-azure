output "resource_group" {
  value = local.rg_name
}

output "resource_group_location" {
  value = local.rg_loc
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}
