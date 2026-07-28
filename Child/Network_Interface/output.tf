
output "nic-op" {
    value = {
        for key, object in azurerm_network_interface.nics:
        key=>{
            id=object.id
        }
    }
  
}