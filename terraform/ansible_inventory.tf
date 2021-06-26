#resource "null_resource" "ansible_inventory" {
#  provisioner "local-exec" {
#    command = "echo '${data.template_file.dev_hosts.rendered}' > dev_hosts"
#  }
#}

resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory"
  content  = <<-EOF
    [eve-ng]
    ${azurerm_public_ip.main.fqdn}
    EOF
}
