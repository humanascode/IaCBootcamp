
locals {
  suffix = "tfdemo2"
  location = "westeurope"
  vnetName = "vnet1"
  vnetAddressSpace = ["10.0.0.0/16"]
  subnetAddressSpace = ["10.0.0.0/24"]
  subnetName = "subnet1"
  publicIpName = "pip"
  publicIpAllocation = "Dynamic"
  nicName = "nic"
  privateIpAllocation = "Dynamic"

}
