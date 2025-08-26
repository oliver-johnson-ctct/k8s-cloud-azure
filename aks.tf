resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = local.rg_loc
  resource_group_name = local.rg_name
  dns_prefix          = "${var.prefix}-dns"
  sku_tier            = "Free"
  identity { type = "SystemAssigned" }
  default_node_pool {
    name                 = var.nodepool_name
    node_count           = var.node_count
    vm_size              = var.node_vm_size
    vnet_subnet_id       = azurerm_subnet.subnet_nodes.id
  }
  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
  }
  role_based_access_control_enabled = true
  lifecycle {
    ignore_changes = [ default_node_pool[0].node_count ]
  }
}


# resource "azurerm_kubernetes_cluster_node_pool" "additional" {
#   name                  = "two"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
#   vm_size               = var.node_vm_size
#   node_count            = 2
#   os_disk_size_gb       = 30
# }

# data "azurerm_kubernetes_cluster" "credentials" {
#   name                = azurerm_kubernetes_cluster.default.name
#   resource_group_name = azurerm_resource_group.default.name
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
#     client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
#     client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
#     cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)

#   }
# }

# resource "helm_release" "hello_kubernetes" {
#   name       = "my-hello-kubernetes"
#   repository = "https://helmcharts.opsmx.com/"
#   chart      = "hello-kubernetes"
# }