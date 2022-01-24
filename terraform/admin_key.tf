resource "azurerm_ssh_public_key" "main" {
  name                = "admin_ssh_key"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  public_key          = file("files/id_rsa.pub")
  tags                = var.tags
}
