output "pip-op" {
  
  value = {
    for key, object in azurerm_public_ip.pips:
    key=>{
        id=object.id
    }
  }
}