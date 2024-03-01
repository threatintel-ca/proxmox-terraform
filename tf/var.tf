variable "cloudinit_template_name" {
  type = string
}

variable "ssh_keys" {
  type = object({
    priv = string
    pub  = string
  })
  default = {
    priv = "~/.ssh/id_rsa"
    pub  = "~/.ssh/id_rsa.pub"
  }
}

variable "cloudinit_user" {
  type    = string
  default = "ansibleuser"
}

variable "pm_storage" {
  description = "Storage device for Proxmox VMs (Shared storage is required)"
  type        = string
  default     = "pm-data"
}

variable "vm_prefix" {
  description = "prefix for unique vm hostname"
  type        = string
  default     = "new"
}

variable "vlan_id" {
  description = "Network VLAN ID"
  type        = number
  default     = 1
}

variable "vms" {
  type = list(object({
    target_node = string
    tags        = string
    ip          = string
    cores       = number
    sockets     = number
    memory      = number
    onboot      = bool
  }))
}
