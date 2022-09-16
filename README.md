Azure Storage Account Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

- This terraform module will create a Storage Account.
- This project is a part of opstree's ot-azure initiative for terraform modules.

## Information:

Terraform Module to create an Azure storage account with a set of containers (and access level),set of containers (without access level), set of file shares (and quota), tables, queues, Network policies and Blob lifecycle management.

-  To defines the Tier to account, set the argument to    `account_tier = "Standard"`. Account kind defaults to `StorageV2`. If you want to change this value to other storage accounts kind,then 
   set the argument to `account_tier = "Premium"` and `account_type` variable must be specified. 
   The valid for `account_type` are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. This will automatically compute the appropriate values for `account_kind`,.  `static_website` can only be set when the account_kind is set to `StorageV2`.


- The creation of blob containers depends on the `allow_nested_items_to_be_public` variable.
   ### Case-1:
   When `allow_nested_items_to_be_public` = false ,then you have to provide the value of `access_type` = `null`
   ### Case-2:
   When `allow_nested_items_to_be_public` = true ,then you have to provide the value of `access_type` = `string` . Valid options are `private`,`blob`,`container`.
   Sample usage is provided below in `Container` section.



## Resources supported:

* [Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
* [Containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
* [SMB File Shares](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)
* [Storage Table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table)
* [Storage Queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue)
* [Network Policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules)
* [Azure Blob storage lifecycle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

## Module Usage

```hcl
provider "azurerm" {
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
#Enter the name of Rsource group you want to make.
#Specify the location in which you want you resource group to be made
#You can also specify tags as per your requirement

module "resource_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  resource_group_name     = "storage-rg-7"
  resource_group_location = "eastus"

  tag_map = {
    Name = "AzureRG"
  }
}
# Storage account module

module "storage_account" {
  source                   = "../../"
  storage_account_name     = "storage44554"
  resource_group_name      = module.res_group.resource_group_name
  location                 = module.res_group.resource_group_location
  account_tier             = "Standard"
  account_type             = "StorageV2"
  account_replication_type = "LRS"

  tags = {
    environment = "testing"
  }
```
Inputs
------
 Name | Description | Type | Default | Required 
------|-------------|------|---------|:--------:
`resource_group_name` |  The name of the resource group in which resources are created | `string` | "" | Yes 
`location` |  The location of the resource group in which resources are created | `string` | "" | Yes 
`storage_account_name` |  The name of the storage account | `string` | "" | Yes
`account_replication_type` |  The Replication type for your Azure Storage. Valid options are LRS, ZRS, GRS, GZRS | `string` | LRS | No
`account_tier` | The account tier of storage account. Valid options are Standard or Premium | `string` | "Standard" | No
`account_type` |  Choose an account type that matches your storage needs and optimizes your costs. Valid options are Storage,BlobStorage,BlockBlobStorage,FileStorage,StorageV2 | `string` | "" | No
`account_kind` |  This depends on `account_tier` and `account_type` | `string` | "" | No
`access_tier` | Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool. | `string` | "Hot" | No
`min_tls_version` |  The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2` | `string`| "TLS1_2" | No
`enable_https_traffic_only` |  Boolean flag which forces HTTPS if enabled. |   `bool` | true | No
`blob_soft_delete_retention_days` | Specifies the number of days that the blob should be retained, between `1` and `365` days. | `number` | 7 | No
`container_soft_delete_retention_days` | Specifies the number of days that the blob should be retained, between `1` and `365` days. | `number` | 7 | No
`enable_versioning` | Is versioning enabled? | `bool` | false | No
`last_access_time_enabled` | Is the last access time based tracking enabled. | `bool` | false | No
`change_feed_enabled` | Is the blob service properties for change feed events enabled? | `bool` | false | No
`allow_nested_items_to_be_public` | To give public access to your blob containers | `string` | false | No
`routing` | Choose between  MicrosoftRouting and InternetRouting | `string` | MicrosoftRouting | No
`net_rules_default_action` | Specifies the default action of Allow or Deny when no other rules match. | `string` | Deny | No
`net_rules_ip_rules` | List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. | `list` | null | No
`net_rules_virtual_network_subnet_ids` | A list of virtual network subnet ids to to secure the storage account. | `list` | null | No
`net_rules_bypass` | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `list` | null | No
`containers_list` | List of container | `list` | [] | No
`file_shares` | List of SMB file shares | `list` | [] | No
`queues` | List of storages queues | `list` | [] | No
`tables` | List of storage tables | `list` | [] | No
`tags` | A map of tags to add to all resources | `map` | {} | No

## BlockBlobStorage accounts

A BlockBlobStorage account is a specialized storage account in the premium performance tier for storing unstructured object data as block blobs or append blobs. Compared with general-purpose v2 and BlobStorage accounts, BlockBlobStorage accounts provide low, consistent latency and higher transaction rates.

BlockBlobStorage accounts don't currently support tiering to hot, cool, or archive access tiers. This type of storage account does not support page blobs, tables, or queues.

To create BlockBlobStorage accounts, set the argument to `account_kind = "BlockBlobStorage"`.

## FileStorage accounts

A FileStorage account is a specialized storage account used to store and create premium file shares. This storage account kind supports files but not block blobs, append blobs, page blobs, tables, or queues.

FileStorage accounts offer unique performance dedicated characteristics such as IOPS bursting. For more information on these characteristics, see the File share storage tiers section of the Files planning guide.

To create BlockBlobStorage accounts, set the argument to `account_kind = "FileStorage"`.

## Containers

A container organizes a set of blobs, similar to a directory in a file system. A storage account can include an unlimited number of containers, and a container can store an unlimited number of blobs. The container name must be lowercase.

This module creates the containers based on your input within an Azure Storage Account.  Configure the `access_type` for this Container as per your preference. Possible values are `blob`, `container` or `private`. Preferred Defaults to `private`.

## SMB File Shares

Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol. Azure file shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.

This module creates the SMB file shares based on your input within an Azure Storage Account.  Configure the `quota` for this file share as per your preference. The maximum size of the share, in gigabytes. For Standard storage accounts, this must be greater than `0` and less than `5120` GB (5 TB). For Premium FileStorage storage accounts, this must be greater than `100` GB and less than `102400` GB (100 TB).

## Configure Azure Storage firewalls and virtual networks

The Azure storage firewall provides access control access for the public endpoints of the storage account.  Use network policies to block all access through the public endpoint when using private endpoints. The storage firewall configuration also enables select trusted Azure platform services to access the storage account securely.

The default action set to `Allow` when no network rules matched. A `subnet_ids` or `ip_rules` can be added to `network_rules` block to allow a request that is not Azure Services.

```hcl
 #Sample usage:

# If specifying network_rules, one of either `ip_rules` or `subnet_ids` must be specified
  default_action             = "Allow
  ip_rules                   = ["1.2.3.4"]
  virtual_network_subnet_ids = []
  bypass                     = ["AzureServices"]

  
```
  ## Manage the Azure Blob storage lifecycle

Azure Blob storage lifecycle management offers a rich, rule-based policy for General Purpose v2 (GPv2) accounts, Blob storage accounts, and Premium Block Blob storage accounts. Use the policy to transition your data to the appropriate access tiers or expire at the end of the data's lifecycle.

The lifecycle management policy lets you:

* Transition blobs to a cooler storage tier (hot to cool, hot to archive, or cool to archive) to optimize for performance and cost
* Delete blobs at the end of their lifecycles
* Apply rules to containers or a subset of blobs*
* Apply Versioning to data in blob container.

```hcl
#Sample usage for blob_properties
delete_retention_policy {
      days = 12
    }
    container_delete_retention_policy {
      days = 11
    }
    #Use boolian value for the arguments given below
    versioning_enabled       = true
    last_access_time_enabled = false
    change_feed_enabled      = true
```


### `Container` objects (must have keys)

Name | Description | Type | Default
---- | ----------- | ---- | -------
`name` | Name of the container | string | `""`
`access_type` | The Access Level configured for the Container. Possible values are `blob`, `container` or `private`.|string|`"private"`

### Case-1
When `allow_nested_items_to_be_public` = false
Usage:
```hcl
containers_list = [
    { name = "container1", access_type = null },
    { name = "container2", access_type = null },
    { name = "container3", access_type = null }
  ]
```  
### Case-2
When `allow_nested_items_to_be_public` = true
Usage:
```hcl
containers_list = [
    { name = "container1", access_type = "private" },
    { name = "container2", access_type = "blob" },
    { name = "container3", access_type = "container" }
  ]
``` 

 

### `file Shares` objects (must have keys)

Name | Description | Type | Default
---- | ----------- | ---- | -------
`name` | Name of the SMB file share | string | `""`
`quota` | The required size in GB. Defaults to `5120`|string|`""


## Outputs

Name | Description
---- | -----------
`storage_account_id`|The ID of the storage account
`sorage_account_name`|The name of the storage account
`primary_blob_endpoint`|The endpoint URL for web storage in the primary location
`secondary_blob_endpoint`|The endpoint URL for web storage in the secondary location
`primary_access_key`|The primary access key for the storage account
`secondary_access_key`|The secondary access key for the storage account



### Contributors
|  [![Deepak Kumar][deepak_avatar]][deepak_homepage]<br/>[Deepak Kumar][deepak_homepage] |
|---|

[deepak_homepage]: https://gitlab.com/deepak.kumar34
[deepak_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10842436/avatar.png?width=400
