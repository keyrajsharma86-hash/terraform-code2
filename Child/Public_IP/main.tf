variable "pips" { 
}
variable "resource_groups" {}
resource "azurerm_public_ip" "pips" {
    for_each = var.pips
    name = each.value.name
    resource_group_name =var.resource_groups[each.value.resource_group_name].name
    location = var.resource_groups[each.value.resource_group_name].location
    allocation_method = "Static"
     
}