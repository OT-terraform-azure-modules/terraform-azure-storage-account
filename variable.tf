variable "resource_group_name" {
  description = "(Required) Resource group name in which you storage account will be created"
  default     = ""
}

variable "location" {
  description = "(Required) The location of the resource group in which resources are created"
  default     = ""
}


variable "storage_account_name" {
  description = "(Required) The name must be unique across all existing storage account names in Azure. It must be 3 to 24 characters long, and can contain only lowercase letters and numbers."
  default     = ""
  validation {
    condition     = length(var.storage_account_name) > 3 && length(var.storage_account_name) < 24
    error_message = "Storage account name must be between 3 to 24 letters."
  }
}

variable "account_replication_type" {
  type        = string
  description = "(Required) The Replication type for your Azure Storage. Valid options are LRS, ZRS, GRS, GZRS"
  default     = ""
}

variable "account_tier" {
  type        = string
  description = "(Required) The account tier of storage account. Valid options are Standard or Premium"
  default     = ""
}


variable "account_type" {
  type        = string
  description = "(Optional) Choose an account type that matches your storage needs and optimizes your costs. Valid options are Storage,BlobStorage,BlockBlobStorage,FileStorage,StorageV2"
  default     = ""
  validation {
    condition     = contains(["Storage", "BlobStorage", "BlockBlobStorage", "FileStorage", "StorageV2"], var.account_type)
    error_message = "Account type must Storage,BlobStorage,BlockBlobStorage,FileStorage or StorageV2."
  }
}

variable "account_kind" {
  type        = string
  description = " (Reduired) Choose an account type that matches your storage needs and optimizes your costs. Valid options are Storage,BlobStorage,BlockBlobStorage,FileStorage,StorageV2"
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
    Name        = "testing"
    environment = "prod"
  }
  description = "(Optional) Tag which will associated to the Storage Account."
}

#-------------------------------new-------------------------------------------------------------------

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the storage account.Possible values are TLS1_0, TLS1_1, and TLS1_2"
  default     = "TLS1_2"
}

variable "enable_https_traffic_only" {
  description = " (optional) Boolean flag which forces HTTPS if enabled. Defaults to true"
  type        = bool
  default     = true
}

#--------------------------------------Networking-----------------------------------------------------

variable "net_rules_default_action" {
  description = "(Required) Specifies the default action of Allow or Deny when no other rules match. Valid options are Deny or Allow"
  type        = string
  default     = "Deny"
}

variable "net_rules_ip_rules" {
  description = " (Optional) List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed"
  type        = list(string)
  default     = null
}

variable "net_rules_virtual_network_subnet_ids" {
  description = " (Optional) A list of virtual network subnet ids to to secure the storage account"
  type        = list(string)
  default     = null
}

variable "net_rules_bypass" {
  description = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None"
  type        = list(string)
  default     = null
}
#-------------------------------blob properties---------------------------------------------------------------------

variable "blob_soft_delete_retention_days" {
  type        = number
  description = "(Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`"
  default     = 7
  validation {
    condition     = var.blob_soft_delete_retention_days > 0 && var.blob_soft_delete_retention_days < 366
    error_message = "Please enter a number between 1 and 365."
  }
}

variable "container_soft_delete_retention_days" {
  type        = number
  description = "(Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`"
  default     = 7
  validation {
    condition     = var.container_soft_delete_retention_days > 0 && var.container_soft_delete_retention_days < 366
    error_message = "Please enter a number between 1 and 365."
  }
}

variable "enable_versioning" {
  description = "(Optional) Is versioning enabled? Default to `false`"
  default     = false
}

variable "change_feed_enabled" {
  description = "(Optional) Is the blob service properties for change feed events enabled?"
  default     = false
}

variable "allow_nested_items_to_be_public" {
  description = "To give public access to your blob containers Default to `false`"
  default     = false
}

variable "last_access_time_enabled" {
  description = "(Optional) Is the last access time based tracking enabled? Default to `false`"
  default     = false
}

variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)"
  default     = true
}

variable "routing" {
  type        = string
  description = "(Optional) Choose between  MicrosoftRouting and InternetRouting.Default is MicrosoftRouting "
  default     = "MicrosoftRouting"
}

#----------------------------------Storage types-----------------------------------------------------

variable "containers_list" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, access_type = string }))

  default = []
}

variable "file_shares" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, quota = number }))

  default = []
}

variable "queues" {
  description = "List of storages queues"
  type        = list(string)
  default     = []
}

variable "tables" {
  description = "List of storage tables."
  type        = list(string)
  default     = []
}


