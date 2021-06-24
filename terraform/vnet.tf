resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.address_space]
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet" "main" {
  name                 = "snet-${var.suffix}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.main.address_space[0], 0, 0)]
  #https://www.terraform.io/docs/language/functions/cidrsubnet.html
}
