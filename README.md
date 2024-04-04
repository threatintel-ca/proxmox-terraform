# Cloud Templates Script for Proxmox

This script (cloudtemplates.sh) simplifies the creation of cloud templates for Ubuntu and Debian on Proxmox Virtual Environment (Proxmox VE). It facilitates the setup of cloud images using the local-lvm storage type.

## Prerequisites

Before running the script, ensure the following:

    You have access to a Proxmox VE server.
    You have administrative privileges or sufficient permissions to create templates.
    You have the necessary cloud image files for Ubuntu and Debian.
    You have python3-pip installed along with `netaddr` package.

## Usage

### 1. Download the Script

Download the cloudtemplates.sh script to your local machine.
2. Make the Script Executable

```bash
chmod +x cloudtemplates.sh
```

### 3. Run the Script
Ubuntu Cloud Template

To create an Ubuntu cloud template with local-lvm storage type:

```bash
./cloudtemplates.sh ubuntu local-lvm
```

Debian Cloud Template

To create a Debian cloud template with local-lvm storage type:

```bash
./cloudtemplates.sh debian local-lvm
````

# Creating a `terraform-prov` User for the Terraform Proxmox Provider

The [Telmate Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) for Terraform allows users to manage Proxmox Virtual Environment (Proxmox VE) resources using Terraform configuration.

## Purpose of the `terraform-prov` User

To interact with the Proxmox API securely, the Terraform Proxmox Provider requires a dedicated user with appropriate permissions. This user, commonly named `terraform-prov`, is used by Terraform to authenticate and perform actions on Proxmox VE resources.

``` 
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

# Required Environment Variables for `deploy.sh`

The `deploy.sh` script is designed to deploy an application or perform specific tasks in a controlled environment. Before executing `deploy.sh`, ensure that the following environment variables are set appropriately to configure and customize the deployment process.


Example:
```bash
export TF_VAR_PM_ENDPOINT="https://pve.example.com:8006/"
export PM_USER="username"
export PM_PASS="password"
```

# Modifying `terraform.tfvars` for VM Deployment

To deploy new virtual machines (VMs) using Terraform, you need to modify the `terraform.tfvars` file in each subdirectory containing Terraform configurations. This file contains variables and configurations specific to the Terraform modules used for VM deployment.

## Purpose of `terraform.tfvars`

The `terraform.tfvars` file is used to define values for Terraform variables. These variables specify parameters such as VM instance types, disk sizes, network configurations, and other settings required for VM deployment.

## Modifying `terraform.tfvars`

Before deploying new VMs, follow these steps to modify the `terraform.tfvars` file in each subdirectory:

1. **Navigate to Subdirectory**: Go to the directory containing the Terraform configurations for VM deployment.

2. **Edit `terraform.tfvars`**: Open the `terraform.tfvars` file in a text editor.

3. **Define Variable Values**: Set values for the Terraform variables defined in the file. These values should reflect the desired configuration for the new VMs to be deployed.

   Example `terraform.tfvars` file:
   ```hcl
    pm_storage              = "local-lvm"
    cloudinit_template_name = "example-cloud-qemu"
    vlan_id                 = 1
    vm_prefix               = "example"

    ssh_keys = {
      pub  = "/home/user/.ssh/id_rsa.pub",
      priv = "/home/user/.ssh/id_rsa"
    }

    vms = [
      {
        target_node = "node-1",
        tags        = "example-tag",
        ip          = "192.168.0.20",
        sockets     = 2,
        cores       = 2,
        memory      = 4096,
        onboot      = true
      }
    ]
   ```
4. **Save Changes**: Save the changes to the terraform.tfvars file.
