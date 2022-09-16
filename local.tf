locals {
  account_kind = (var.account_tier == "Standard" ? "StorageV2" : var.account_type)

}
