#!/bin/bash

storage_device="$2:?Missing storage device i.e. local-lvm"

if ! command -v virt-customize &>/dev/null; then
	apt install guestfs-tools
fi

if [ "$1" = "ubuntu" ]; then
	wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
	apt install guestfs-tools
	virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent
	qm create 9000 --memory 2048 --core 2 --name ubuntu-cloud-jammy-qemu --net0 virtio,bridge=vmbr0
	qm importdisk 9000 jammy-server-cloudimg-amd64.img $storage_device
	qm set 9000 --scsihw virtio-scsi-pci --scsi0 $storage_device:vm-9000-disk-0
	qm set 9000 --ide2 $storage_device:cloudinit
	qm set 9000 --boot c --bootdisk scsi0
	qm set 9000 --serial0 socket --vga serial0
	qm template 9000
fi

if [ "$1" = "debian" ]; then
	wget https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2
	virt-customize -a debian-11-generic-amd64.qcow2 --install qemu-guest-agent
	qm create 9001 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
	qm importdisk 9001 debian-11-generic-amd64.qcow2 $storage_device
	qm set 9001 --scsihw virtio-scsi-pci --scsi0 $storage_device:vm-9001-disk-0
	qm set 9001 --ide2 $storage_device:cloudinit
	qm set 9001 --boot c --bootdisk scsi0
	qm set 9001 --serial0 socket --vga serial0
	qm template 9001
fi
