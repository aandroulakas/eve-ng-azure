data "http" "pip_ipv4" {
  url = "http://ipv4.ident.me"
}

#If your ISP is NOT providing an IPv6 , comment out lines 6-8
data "http" "pip_ipv6" {
  url = "http://ipv6.ident.me"
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg-${var.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound_ipv4" {
  name                        = "AllowServicesInBoundIPv4"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefixes     = [data.http.pip_ipv4.body]
  destination_port_ranges     = [22, 80]
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 100
  direction                   = "Inbound"
}

#If your ISP is NOT providing an IPv6, comment out lines 32-44
resource "azurerm_network_security_rule" "inbound_ipv6" {
  count = [data.http.pip_ipv6.body] != 0 ? 1 : 0

  name                        = "AllowServicesInBoundIPv6"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefixes     = [data.http.pip_ipv6.body]
  destination_port_ranges     = [22, 80]
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 101
  direction                   = "Inbound"
}

resource "azurerm_network_security_rule" "inbound_ipv4_telnet" {
  name                        = "AllowTelnetInBoundIPv4"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefixes     = [data.http.pip_ipv4.body]
  destination_port_range      = "32769 - 32788"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 102
  direction                   = "Inbound"
}

#If your ISP is NOT providing an IPv6, comment out lines 63-77
resource "azurerm_network_security_rule" "inbound_ipv6_telnet" {
  count = [data.http.pip_ipv6.body] != 0 ? 1 : 0

  name                        = "AllowTelnetInBoundIPv6"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefixes     = [data.http.pip_ipv6.body]
  destination_port_range      = "32769 - 32788"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 103
  direction                   = "Inbound"
}

resource "azurerm_network_security_rule" "inbound_deny_all" {
  name                        = "DenyAllInBound_Override" # default rule 65500
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
  description                 = "Any inbound rules with a higher priority than this one will be ignored."
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "*"
  destination_address_prefix  = "*"
  access                      = "Deny"
  priority                    = 4055
  direction                   = "Inbound"
}
