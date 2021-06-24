variable "admin_username" {
  type        = string
  description = "The admin user for the VM"
}

variable "resource_group_name" {
  type        = string
  default     = "eve-ng"
  description = "The name of the Resource Group"
}

variable "suffix" {
  type        = string
  default     = "eve-ng"
  description = "The suffix which will be used in naming Azure resources"
}

variable "eveng_fqdn" {
  type        = string
  default     = ""
  description = "What is the FQDN you would like the EVE-NG server to resolve to?"
}

variable "address_space" {
  type        = string
  description = "The address space that is used the virtual network."
}

variable "location" {
  type        = string
  default     = "uksouth" # London
  description = "The Azure Region where the Resource Group should exist."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources."
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "Specifies the size of the Virtual Machine."
}

variable "disk_size_gb" {
  type        = number
  default     = 100
  description = "Disk size in GB"
}

variable "subscription_id" {
  type        = string
  default     = ""
  description = "The Azure Subscription ID where you want to deloy resources"
}

variable "tenant_id" {
  type        = string
  default     = ""
  description = "The Azure Tenant ID where you want to deloy resources"
}
