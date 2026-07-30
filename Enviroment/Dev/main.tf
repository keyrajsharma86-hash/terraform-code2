variable "rgs" {}
variable "vnets" {}
variable "subnets" {}
variable "pips" {}
variable "nics" {}
variable "vms" {
}


module "resource_group" {
    source = "../../Child/Resource_Group"
  rgs=var.rgs
}
module "vnets"{
  source = "../../Child/Virtual_Network"

  vnets=var.vnets
  resource_groups=module.resource_group.resource_groups

  depends_on = [ module.resource_group ]
}
module "subnets" {
  depends_on = [ module.vnets ]
  source = "../../Child/Subnet"
  subnets=var.subnets
  vnetname=module.vnets.vnetop
  resource_groups=module.resource_group.resource_groups
  }

  module "pips" {
    source = "../../Child/Public_IP"
    pips=var.pips
     resource_groups=module.resource_group.resource_groups
      depends_on = [ module.resource_group]
  }

  module "nics" {
    source = "../../Child/Network_Interface"
    nics=var.nics
    subnet_id=module.subnets.subnet-op
    pipid=module.pips.pip-op
     resource_groups=module.resource_group.resource_groups
      depends_on = [ module.resource_group,module.pips,module.subnets]
  }


module "nsg" {
  depends_on = [ module.resource_group,module.nics ]
  source = "../../Child/Network_Security_Group"
  nics=module.nics.nic-op
}

  module "vms" {
    source = "../../Child/Virtual_Machine"
    vms=var.vms
    nics=module.nics.nic-op
    resource_groups=module.resource_group.resource_groups
      depends_on = [ module.resource_group,module.pips,module.subnets,module.nsg]
  }