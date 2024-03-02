pm_storage              = "pm-data"
cloudinit_template_name = "ubuntu-cloud-jammy-qemu"
vlan_id                 = 1
vm_prefix               = "k3s"

ssh_keys = {
  pub  = "/home/user/.ssh/id_rsa.pub",
  priv = "/home/user/.ssh/id_rsa"
}

vms = [
  {
    target_node = "node-1",
    tags        = "k3s_cluster,master",
    ip          = "192.168.0.20",
    sockets     = 1,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  },
  {
    target_node = "node-1",
    tags        = "k3s_cluster,master",
    ip          = "192.168.0.21",
    sockets     = 1,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  },
  {
    target_node = "node-1",
    tags        = "k3s_cluster,master",
    ip          = "192.168.0.22",
    sockets     = 1,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  },
  {
    target_node = "node-1",
    tags        = "k3s_cluster,node",
    ip          = "192.168.0.23",
    sockets     = 2,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  },
  {
    target_node = "node-1",
    tags        = "k3s_cluster,node",
    ip          = "192.168.0.24",
    sockets     = 2,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  },
  {
    target_node = "node-1",
    tags        = "k3s_cluster,node",
    ip          = "192.168.0.25",
    sockets     = 2,
    cores       = 2,
    memory      = 4096,
    onboot      = true
  }
]
