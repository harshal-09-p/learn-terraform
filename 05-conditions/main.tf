variable "demo" {
  default = true
}

variable "demo1" {
  default = false
}

resource "null_resource" "demo" {
 count = var.demo ? 1 : 0  
}

resource "null_resource" "demo1" {
  count = var.demo1 ? 1: 0 
}

variable "nodes" {
    default = {
        test1 = {
            private_ip_address_allocation = "Dynamic"
        }
        test2 = {
        }
    }
  
}

provider "azurerm" {
  features {}
  subscription_id = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"
}

resource "azurerm_network_interface" "privateip" {
  for_each              = var.nodes
  name                  = "${each.key}-i"
  location              = "UK West"
  resource_group_name   = "devops_project_ecom"

  ip_configuration {
    name                          = each.key
    subnet_id                     = "/subscriptions/4a491ea7-cd6d-4ec6-aa18-28b31973e70c/resourceGroups/devops_project_ecom/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/default"
    private_ip_address_allocation = length(try(each.value["private_ip_address_allocation"], "")) > 0 ? each.value["private_ip_address_allocation"] : "static"
  }
}