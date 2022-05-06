provider "azurerm" {
  features {}

}


module "res_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  resource_group_name     = "storage-rg-demo"
  resource_group_location = "eastus"

  tag_map = {
    Name = "AzureRG"
  }
}

module "storage_account" {
  source                   = "../../"
  storage_account_name     = "storage999800asd"
  resource_group_name      = module.res_group.resource_group_name
  location                 = module.res_group.resource_group_location
  account_tier             = "Standard"
  account_type             = "StorageV2"
  account_replication_type = "LRS"

  tags = {
    environment = "testing"
  }

  containers_list = [
    { name = "container1", access_type = "private" },
    { name = "container2", access_type = "blob" },
    { name = "container3", access_type = "container" }
  ]
}
