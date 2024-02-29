resource "proxmox_vm_qemu" "k3s" {
  count                   = length(var.vms)
  name                    = "${var.vm_prefix}-${count.index}"
  target_node             = var.vms[count.index].target_node
  clone                   = var.cloudinit_template_name
  os_type                 = "cloud-init"
  cores                   = var.vms[count.index].cores
  sockets                 = var.vms[count.index].sockets
  cpu                     = "host"
  memory                  = var.vms[count.index].memory
  scsihw                  = "virtio-scsi-pci"
  bootdisk                = "scsi0"
  cloudinit_cdrom_storage = var.pm_storage
  ciuser                  = var.cloudinit_user
  tags                    = var.vms[count.index].tags
  agent                   = 1
  full_clone              = true
  define_connection_info  = true
  ssh_user                = var.cloudinit_user
  ssh_private_key         = file(var.ssh_keys.priv)

  disks {
    scsi {
      scsi0 {
        disk {
          size    = 100
          storage = var.pm_storage
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = var.vlan_id
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0  = "ip=${var.vms[count.index].ip}/24,gw=${cidrhost(format("%s/24", var.vms[count.index].ip), 1)}"
  nameserver = cidrhost(format("%s/24", var.vms[count.index].ip), 1)

  sshkeys = <<EOF
  ${file(var.ssh_keys.pub)}
  EOF

  connection {
    host        = var.vms[count.index].ip
    user        = var.cloudinit_user
    private_key = file(var.ssh_keys.priv)
    agent       = false
    timeout     = "3m"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Ready for provisioning'"]
  }

  #  provisioner "local-exec" {
  #  working_dir = "../ansible/"
  #  command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.cloudinit_user} --key-file ${var.ssh_keys.priv} -v -i ${var.vms[count.index].ip}, install-qemu-guest-agent.yaml"
  #}
}
