terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "4.70.0"
    }
  }
backend "azurerm" {
  resource_group_name       = "keyraj-storage"
  storage_account_name      = "backendstoragekeyraj"
  container_name            = "backendcontainer"
  key                       = "dev/tfstate"

}


}

provider "azurerm" {
features{}
}
