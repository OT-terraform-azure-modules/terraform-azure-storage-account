resource "azurerm_storage_account" "storage_account" {
  name                            = lower(var.storage_account_name)
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_kind                    = local.account_kind
  account_replication_type        = var.account_replication_type
  access_tier                     = var.access_tier
  min_tls_version                 = var.min_tls_version
  enable_https_traffic_only       = var.enable_https_traffic_only
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  shared_access_key_enabled       = var.shared_access_key_enabled
  tags                            = var.tags

  blob_properties {
    delete_retention_policy {
      days = var.blob_soft_delete_retention_days
    }
    container_delete_retention_policy {
      days = var.container_soft_delete_retention_days
    }
    versioning_enabled       = var.enable_versioning
    last_access_time_enabled = var.last_access_time_enabled
    change_feed_enabled      = var.change_feed_enabled

  }
  routing {
    choice = var.routing
  }


}

# Creates Storage Account network rules

resource "azurerm_storage_account_network_rules" "net_rules" {
  storage_account_id         = azurerm_storage_account.storage_account.id
  default_action             = var.net_rules_default_action
  ip_rules                   = var.net_rules_ip_rules
  virtual_network_subnet_ids = var.net_rules_virtual_network_subnet_ids
  bypass                     = var.net_rules_bypass



}


# Storage Container Creation

resource "azurerm_storage_container" "container" {
  count                 = length(var.containers_list)
  name                  = var.containers_list[count.index].name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.containers_list[count.index].access_type
}


# Storage Fileshare Creation

resource "azurerm_storage_share" "fileshare" {
  count                = length(var.file_shares)
  name                 = var.file_shares[count.index].name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.file_shares[count.index].quota
}


# Storage Tables Creation

resource "azurerm_storage_table" "tables" {
  count                = length(var.tables)
  name                 = var.tables[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}


# Storage Queue Creation

resource "azurerm_storage_queue" "queues" {
  count                = length(var.queues)
  name                 = var.queues[count.index]
  storage_account_name = azurerm_storage_account.storage_account.name
}



