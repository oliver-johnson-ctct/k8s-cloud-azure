  
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.vnet_address_space]
  location            = local.rg_loc
  resource_group_name = local.rg_name
}
resource "azurerm_subnet" "subnet_nodes" {
  name                 = "${var.prefix}-nodes"
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}
