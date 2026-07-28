variable "vms" {}
variable "resource_groups" {}
variable "nics" {}

resource "azurerm_linux_virtual_machine" "vms" {

  for_each = var.vms

  name = each.value.name

  location = var.resource_groups[each.value.resource_group_name].location

  resource_group_name = var.resource_groups[each.value.resource_group_name].name

  size = each.value.size

  admin_username = each.value.admin_username

  admin_password = each.value.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    var.nics[each.value.network_interface_name].id
  ]

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }
}