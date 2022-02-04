# EVE-NG deployment in Azure with Terraform & Ansible

This repository uses [Terraform](https://terraform.io) to create and manage Azure
infrastructure and [Ansible](https://ansible.com) to manage the images and the
configuration of an EVE-NG server in MS Azure.
By using those tools, we are able to have an EVE-NG server ready in less than 20 minutes !!


# Why?

Because one of the most frequently asked question from friend and colleagues is: How do you lab, what equipment do you use?


## Why an EVE-NG server in MS Azure?

 - No CAPEX, only OPEX!
 - Scalability and secure access from everywhere with an Internet connection (5G and Starlink will be the norm in few years after all)!

## Why Terraform?

Because is the most popular IaC tool for Cloud deployments.

## Why Ansible?

Because is the most popular configuration management tool.

## Additional Notes

 - Terraform state file is local , there is no need to share the state file with anyone for your personal EVE-NG lab.
 - The Ansible playbook is an adaptation of the EVE-NG Community Edition [bash
script](https://www.eve-ng.net/repo/install-eve.sh).


## Authentication
- Terraform will authenitcate against MS Azure APIs using your `az login` credentials.
- Ansible will authenticate using `SSH private key`.


## Terraform Variables

This project has a few default variables defined in `variables.tf` file.
You can override them by adding the new values into `terraform.tfvars` file.
You should update the variable `eveng_fqdn` to reflect your FQDN preference and
avoid any FQDN duplication. The file `yoursecrets.tfvars` is a place holder for you to include your MS Azure details like:
`subscription_id` and `tenant_id`.

## Before starting with the deployment

Make sure you have Terraform and Ansible installed:

- [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install)
- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


## Deployment steps

1. Clone this repo into your local system:
```bash
$ git clone git@github.com:aandroulakas/eve-ng-azure.git
```

2. Amend the content of the file `yoursecrets.tfvars` to reflect the Azure Tenant and the Azure Subscripiton in which
   you wish to deploy the resources. Use the following commands from the CLI to help you:
```bash
$ az login

$ az account show --query '{AzureTenant:tenantId, SubscripitonID:id, SubscripitonName:name}'
```

3. Place your Public SSH Key (id_rsa.pub) into the directory `eve-ng-azure/terraform/files`. Terraform will push this SSH key to the Azure VM.

4. Load your Private SSH Key (id_rsa) to your `ssh-agent`.
```bash
ssh-add ~/.ssh/id_rsa
```
[More details about creating SSH Keys](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/mac-create-ssh-keys)

4. Place any QEMU image that you wish to use into a new directory `eve-ng-azure/ansible/images`. The structure of the directory is important and MUST be like below:
```bash
$ tree images
images
├── asav-982
│   └── virtioa.qcow2
├── vios-15.5.3M
│   └── virtioa.qcow2
└── viosl2-15.2.4.55e
    └── virtioa.qcow2
```
The structure of the directory is very important because this will be used by Ansible to push the QEMU images from your local system to Azure VM (/opt/unetlab/addons/qemu/).

5. And now the Magic! Navigate to `eve-ng-azure/terraform` and run the following in order:
```bash
$ terraform init

$ terraform plan

$ terraform apply
```
6. Once Terraform deploy the infrastructure in Azure we just need to configure the VM with Ansible. To do so, navigate to `eve-ng-azure/ansible` and run the following:
```bash
$ ansible-playbook -u eve-ng -i inventory playbook.yml
```

> Upload speed of QEMU images depends on your Internet connection.

# Usage after deployment is finished:

Navigate to http://{eveng_fqdn}.
The default credentials of `admin/eve` can be used. The service is only available over HTTP and currently does not redirect or supports HTTPS.

> I'm likely to accept a pull request that configures SSL on EVE-NG server.

# Syncing New Images

You just need to add an additional image into the appropriate directory and re-run Ansible playbook. After placing the new image into the directory `eve-ng-azure/ansible/images`
, navigate to `eve-ng-azure/ansible` and run the following:
```bash
$ cd ~/eve-ng-azure/ansible
$ ansible-playbook -u eve-ng -i inventory playbook.yml
```

# Caveats

> My ISP recently introduced IPv6 to my broadband connection. Thus, I have included IPv6 NSG rules into the file `network_security_group.tf`. If this is not the case for you, please comment any code referencing IPv6 as instructed in the file.

# Basic connectivity test with a simple topology.
In the directory  `eve-ng-azure/lab` , I have included a simple topology (Basic connectivity test.zip) which can be loaded to EVE-NG with the relevant configuration files. The topology is based on Cisco QEMU images.

# Telnet html handle

> In order to have "console" access to the devices `Telnet html handle` will be used. For a smooth process you need to install Client Side as per [instructions](https://www.eve-ng.net/index.php/download/).