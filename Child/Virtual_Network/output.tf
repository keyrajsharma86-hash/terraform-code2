output "vnetop" {
  value = {
    for key, vnet in azurerm_virtual_network.vnets :
    key => {
      id   = vnet.id
      name = vnet.name
    }
  }
}