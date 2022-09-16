output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for Blob container "
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The endpoint URL for Blob container"
  value       = azurerm_storage_account.storage_account.secondary_blob_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage_account.secondary_access_key
  sensitive   = true
}
