pm_api_url              = "https://proxmox:8006/api2/json"
pm_user                 = "terraform-prov@pve"
pm_password             = "password"
pm_storage              = "storage"
cloudinit_template_name = "template-name"
vlan_id                 = 1
vm_prefix               = "new-vm"

ssh_keys = {
  pub  = "~/.ssh/id_rsa.pub",
  priv = "~/.ssh/id_rsa"
}

vms = [
  {
    target_node = "node-1",
    tags        = "tag1,tag2",
    ip          = "192.168.0.10",
    sockets     = 1,
    cores       = 2,
    memory      = 4096
  }
]
