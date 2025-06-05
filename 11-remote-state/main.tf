provider "azurerm" {
  features {}
  subscription_id = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"
}

resource "null_resource" "test" {}

terraform {
  backend "azurerm" {
    use_cli              = true                                    
    subscription_id      = "4a491ea7-cd6d-4ec6-aa18-28b31973e70c"  
    resource_group_name  = "devops_project_ecom"        
    storage_account_name = "tfstoragestate01"                              
    container_name       = "roboshop-tfstate-file"                               
    key                  = test.terraform.tfstate                
  }
}