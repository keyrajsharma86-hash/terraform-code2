variable "subnets" {  
}
variable "resource_groups" {}
variable "vnetname" {
  
}

resource "azurerm_subnet" "subnets" {
    for_each                = var.subnets
    name                    = each.value.name
    virtual_network_name    = var.vnetname[each.value.virtual_network_name].name
    resource_group_name     =var.resource_groups[each.value.resource_group_name].name
    address_prefixes        = each.value.address_prefixes
  
}
