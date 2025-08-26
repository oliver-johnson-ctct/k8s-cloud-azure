variable "suffix" {
  description = "Suffix for resource names - Hamish didn't use"
  type        = number
  default     = 2
}

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
}

variable "nodepool_name" {
	description = "Node pool name"
	type        = string
	default     = "npapps001"
}

variable "node_vm_size" {
	description = "VM size"
	type        = string
	default     = "Standard_D2as_v5"
}

variable "node_count" {
	description = "Initial node count"
	type        = number
	default     = 2
}

variable "kubernetes_version" {
	description = "AKS version (optional)"
	type        = string
	default     = ""
}

variable "location" {
	description = "Azure region"
	type        = string
	default     = "australiaeast"
}