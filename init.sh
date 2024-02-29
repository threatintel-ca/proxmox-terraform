#!/bin/bash

install_anslbie=false
install_terraform=false
install_git=false

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if ! command -v ansible &>/dev/null; then
	echo "Ansible not found"
	install_ansible=true
else
	if [$(version $(ansible --version | egrep -o "core ([0-9]{1,}\.)+[0-9]{1,}" | awk '{print $2}')) -lt $(version "2.11.0")]; then
		install_ansible=true
	fi
fi

if "$install_ansible"; then
	echo "Installing ansible >= 2.11.0"
	apt-add-repository ppa:ansible/ansible -y
	apt update
	apt install ansible -y
	ansible-galaxy collection install community.general
fi

if ! command -v terraform &>/dev/null; then
	install_terraform=true
fi

if "$install_terraform"; then
	echo "Installing terraform"
	apt-get update && apt-get install -y gnupg software-properties-common

	wget -O- https://apt.releases.hashicorp.com/gpg |
		gpg --dearmor |
		tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

	gpg --no-default-keyring \
		--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
		--fingerprint

	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
		tee /etc/apt/sources.list.d/hashicorp.list

	apt update
	apt install terraform -y
fi

if ! command -v git &>/dev/null; then
	install_git=true
fi

if "$install_git"; then
	apt install git -y
fi

git clone https://github.com/techno-tim/k3s-ansible.git ../ansible/k3s/builder/
ansible-galaxy collection install -r ../ansible/k3s/builder/collections/requirements.yml

terraform -chdir="tf" init
cp terraform.tfvars tf/terraform.tfvars
terraform -chdir="tf" apply -var-file="terraform.tfvars"
