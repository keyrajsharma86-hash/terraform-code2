output "subnet-op" {
value = {
    for key,object in azurerm_subnet.subnets:
    key=>
    {id=object.id
    }
}
  
}