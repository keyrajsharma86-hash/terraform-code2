
variable "vnets" {}
variable "resource_groups" {}



resource "azurerm_virtual_network" "vnets" {
  for_each = var.vnets

  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_name].location
  resource_group_name = var.resource_groups[each.value.resource_group_name].name
  address_space       = each.value.address_space
}