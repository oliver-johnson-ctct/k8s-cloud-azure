  #  (Azure): AKS + Terraform + GitHub Actions

  Deploy an AKS cluster using Terraform driven by GitHub Actions.

Fork or clone  https://github.com/HeyMo0sh/k8s-cloud-azure.git

Edit variables.tf and change:

``` text 
variable "resource_group_name" {
	description = "Resource group name"
	type        = string
	default     = "rg-trimble-001"
}

variable "create_rg" {
  description = "Create the RG (true) or reference an existing one (false)"
  type        = bool
  default     = true
}

variable "prefix" {
	description = "Name prefix"
	type        = string
	default     = "aks"
}

variable "aks_name" {
	description = "AKS name"
	type        = string
	default     = "aks-cluster-001"
}

variable "vnet_address_space" {
	description = "VNet CIDR"
	type        = string
	default     = "10.74.1.0/24"
}

variable "subnet_address_prefix" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.74.1.0/26"
}

variable "dns_service_ip" {
	description = "DNS service IP for AKS"
	type        = string
	default     = "10.74.1.33"
}

variable "service_cidr" {
	description = "Service CIDR for AKS"
	type        = string
	default     = "10.74.1.32/26"
```

to your designated number (ie Edwin is 5)

``` text 

variable "resource_group_name" {
	description = "Resource group name"
	type        = string
	default     = "rg-trimble-005"
}

variable "create_rg" {
  description = "Create the RG (true) or reference an existing one (false)"
  type        = bool
  default     = true
}

variable "prefix" {
	description = "Name prefix"
	type        = string
	default     = "aks"
}

variable "aks_name" {
	description = "AKS name"
	type        = string
	default     = "aks-cluster-005"
}

variable "vnet_address_space" {
	description = "VNet CIDR"
	type        = string
	default     = "10.74.5.0/24"
}

variable "subnet_address_prefix" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.74.5.0/26"
}

variable "dns_service_ip" {
	description = "DNS service IP for AKS"
	type        = string
	default     = "10.74.5.33"
}

variable "service_cidr" {
	description = "Service CIDR for AKS"
	type        = string
	default     = "10.74.5.32/26"

```

Complain to Hamish and ask why he didn't do:

``` text
locals {
  full_prefix = "${var.prefix}${var.suffix}"
}

```

Commit and push to your repo

Hopefully it builds a cluster....

**Relish in his discomfort**

Go into Azure Cloud Shell 

OR

connect in a terminal ( you do need Azure CLI)

``` bash
az login
```

run the following commands

```bash
az account set --subscription 7c0e8c21-980c-4a6a-9f75-ef24d677baf8
# I am doing this for cluster 005 - change to your number
az aks get-credentials --resource-group rg-trimble-005 --name aks-cluster-005 --overwrite-existing

kubectl get deployments --all-namespaces=true

kubectl get nodes

kubectl get pods

```

## but there is nothing there (!!)

### Change stuff and push again

```text 

go to terraform-azure.yml and uncomment the last bits:

      # # ---  install kubectl ---
      # - name: Install kubectl
      #   uses: azure/setup-kubectl@v4
      #   with:
      #     version: latest

      # # ---  get kubecontext for the AKS cluster ---
      # - name: Get AKS credentials
      #   run: |
      #     az aks get-credentials \
      #       --resource-group "${{ steps.tfout.outputs.rg }}" \
      #       --name "${{ steps.tfout.outputs.aks }}" \
      #       --admin \
      #       --overwrite-existing

      # # (optional) wait until nodes are ready to avoid flakiness
      # - name: Wait for nodes
      #   run: |
      #     for i in {1..30}; do
      #       kubectl get nodes && break
      #       echo "Waiting for AKS nodes to be ready..."; sleep 10
      #     done

      # # ---  apply manifest ---
      # - name: kubectl apply
      #   run: kubectl apply -f deployment.yml

```

commit and push and go check GitHub actions

You can now  do this:

kubectl get pods

kubectl get svc

curl the IP address of the Load Balancer note the pod that we hit
do it again note the pod that we hit

**Like we did yesterday after our `manual` deploy**

## last bit

In aks.tf file uncomment this:

``` text
# resource "azurerm_kubernetes_cluster_node_pool" "additional" {
#   name                  = "two"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
#   vm_size               = var.node_vm_size
#   node_count            = 2
#   os_disk_size_gb       = 30
# }
```

Commit/push and hopefully once it has built

```bash

kubectl get nodes

```

we had additional nodes
