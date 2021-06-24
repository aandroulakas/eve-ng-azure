provider "azurerm" {
  subscription_id              = var.subscription_id
  tenant_id                    = var.tenant_id
  disable_terraform_partner_id = true
  storage_use_azuread          = true

  features {
  }
}
