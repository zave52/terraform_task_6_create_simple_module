variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_tier" {
  description = "The performance tier of the storage account (Standard or Premium)"
  default     = "Standard"
  type        = string
}

variable "storage_account_replication_type" {
  description = "The replication type for the storage account (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  default     = "GRS"
  type        = string
}
