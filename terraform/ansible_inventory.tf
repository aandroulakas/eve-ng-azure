resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory"
  content  = <<-EOF
    [eve-ng]
    ${azurerm_public_ip.main.fqdn}
    EOF
}
