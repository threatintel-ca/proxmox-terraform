# Creating proxmox QEMU cloud init

NOTE: For cloning to work across a cluster you must have created the drive and template on a shared storage acros the cluster 

On your proxmox host,

create the cloud-init templtae VM

```
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
apt install guestfs-tools
virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent
qm create 8000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
qm importdisk 8000 jammy-server-cloudimg-amd64.img local-lvm
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
qm set 8000 --ide2 local-lvm:cloudinit
qm set 8000 --boot c --bootdisk scsi0
qm set 8000 --serial0 socket --vga serial0
qm template 8000
```

create the terraform user

```
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

# Terraform vars

Update the default values within terraform.tfvars

# How to run

After configuring proxmox and modifying the terraform vars, execute the `init.sh` as `sudo`
