
variable "vmName" {
  type = string
}

variable "vmSku" {
  type = string
  default = "Standard_A4_v2"
  validation {
    condition = var.vmSku == "Standard_A4_v2" || var.vmSku == "Standard_A2_v2"
    error_message = "The vmSku must be one of the following: Standard_A4_v2 or Standard_A2_v2"
  }
}

variable "kvId" {
  type = string
  description = "id for the keyvault holding secrets"
}

variable "userNameSecret" {
  type = string
  default = "DefaultAdminUsername"
}

variable "passwordSecret" {
  type = string
  default = "DefaultAdminPassword"
}
variable "rgName" {
  type = string
}

variable "vmCount" {
  type = number
  default = 3
}