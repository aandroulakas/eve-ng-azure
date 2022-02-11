variable "admin_username" {
  type        = string
  description = "The admin user for the Azure VM"
}

variable "allowed_ipv4" {
  type        = list(string)
  default     = []
  description = "Additional allowed IPv4"
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
  description = "The FQDN you would like the EVE-NG server to resolve to"
}

variable "address_space" {
  type        = string
  description = "The address space of the virtual network."
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
  default     = "Standard_D4s_v4" # 4vCPUs, 16GB RAM
  description = "Specifies the size of the Virtual Machine."
}

variable "disk_size_gb" {
  type        = number
  default     = 100
  description = "Specifies the size of the Data disk in GB"
}

variable "subscription_id" {
  type        = string
  default     = ""
  description = "The Azure Subscription ID where you want to deploy resources"
}

variable "tenant_id" {
  type        = string
  default     = ""
  description = "The Azure Tenant ID where you want to deploy resources"
}
