provider "azurerm" {
  features {}
  subscription_id = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"
}

data "azurerm_resource_group" "example" {
  name = "devops_project_ecom"
}

output "id" {
  value = data.azurerm_resource_group.example.id
}
