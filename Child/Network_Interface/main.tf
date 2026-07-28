variable "nics" {}
variable "resource_groups" {}
variable "subnet_id" {}
variable "pipid" {}
resource "azurerm_network_interface" "nics" {
    for_each = var.nics
    name = each.value.name
    resource_group_name =var.resource_groups[each.value.resource_group_name].name
    location = var.resource_groups[each.value.resource_group_name].location
ip_configuration {
    name = each.value.name1
    subnet_id = var.subnet_id[each.value.subnet_id].id
    public_ip_address_id = var.pipid[each.value.public_ip_address_id].id
    private_ip_address_allocation = "Dynamic"
}


}