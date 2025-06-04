 resource "null_resource" "test" {
   count = 10
 }

 output "testprint" {
   value = null_resource.test
 }

 output "testprint2" {
   value = null_resource.test[*].id
 }

 resource "null_resource" "test1" { }

 output "test1print" {
   value = null_resource.test1.id
 }

provider "azurerm" {
  features {}
  subscription_id = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"
}

 variable "nodes" {
    default = [
        "test2",
        "test1"
    ]
 }

 resource "azurerm_network_interface" "privateip" {
  count                 = length(var.nodes)
  name                  = "${var.nodes[count.index]}"
  location              = "UK West"
  resource_group_name   = "devops_project_ecom"

  ip_configuration {
    name                          = "${var.nodes[count.index]}"
    subnet_id                     = "/subscriptions/4a491ea7-cd6d-4ec6-aa18-28b31973e70c/resourceGroups/devops_project_ecom/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  count                         = length(var.nodes)
  name                          = "${var.nodes[count.index]}"
  location                      = "UK West"
  resource_group_name           = "devops_project_ecom"
  network_interface_ids         = [azurerm_network_interface.privateip[count.index].id]
  vm_size                       = "Standard_B2s"
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true
  
  storage_image_reference {
    id = "/subscriptions/4a491ea7-cd6d-4ec6-aa18-28b31973e70c/resourceGroups/devops_project_ecom/providers/Microsoft.Compute/images/image"
  }
  
  storage_os_disk {
    name              = "${var.nodes[count.index]}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
    computer_name  = "${var.nodes[count.index]}"
    admin_username = "harshal"
    admin_password = "harshal@12345"
  }
  
  os_profile_linux_config {
    disable_password_authentication = false
  }
}