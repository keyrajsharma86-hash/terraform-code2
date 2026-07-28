output "resource_groups" {
  description = "Resource Group details"

  value = {
    for key123, rg1 in azurerm_resource_group.resource_group :
    key123 => {
      id       = rg1.id
      name     = rg1.name
      location = rg1.location
    }
  }
}

