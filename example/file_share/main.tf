povider "azurerm" {
  features {}

}
terraform {
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


module "res_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  resource_group_name     = "storage-rg-99"
  resource_group_location = "eastus"

  tag_map = {
    Name = "AzureRG"
  }
}

module "storage_account" {
  source                   = "../"
  storage_account_name     = "storage2121212"
  resource_group_name      = module.res_group.resource_group_name
  location                 = module.res_group.resource_group_location
  account_tier             = "Standard"
  account_type             = "StorageV2"
  account_replication_type = "LRS"


  tags = {
    environment = "testing"
  }

  file_shares = [
    { name = "fileshare1", quota = 50 },
    { name = "fileshare2", quota = 50 }
  ]






}
