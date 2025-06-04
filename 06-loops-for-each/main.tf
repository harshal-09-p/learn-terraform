provider "azurerm" {
  features {}
  subscription_id = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"
}

 variable "nodes" {
    default = {
        test2 = {
            vm_size = "Standard_B2s"
        }
        test1 = {
            vm_size = "Standard_B2s"
        }
    }
 }

 resource "azurerm_network_interface" "privateip" {
  for_each              = var.nodes
  name                  = each.key
  location              = "UK West"
  resource_group_name   = "devops_project_ecom"

  ip_configuration {
    name                          = each.key
    subnet_id                     = "/subscriptions/4a491ea7-cd6d-4ec6-aa18-28b31973e70c/resourceGroups/devops_project_ecom/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  for_each                      = var.nodes
  name                          = each.key
  location                      = "UK West"
  resource_group_name           = "devops_project_ecom"
  network_interface_ids         = [azurerm_network_interface.privateip[each.key].id]
  vm_size                       = each.value["vm_size"]
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true
  
  storage_image_reference {
    id = "/subscriptions/4a491ea7-cd6d-4ec6-aa18-28b31973e70c/resourceGroups/devops_project_ecom/providers/Microsoft.Compute/images/image"
  }
  
  storage_os_disk {
    name              = "${each.key}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
    computer_name  = each.key
    admin_username = "harshal"
    admin_password = "harshal@12345"
  }
  
  os_profile_linux_config {
    disable_password_authentication = false
  }
}