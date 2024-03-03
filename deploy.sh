export ANSIBLE_HOST_KEY_CHECKING=False

desired_service="${1:?Missing service name [k3s, tpot]}"
desired_action="${2:?Missing action [up, down]}"

if [ "$desired_action" = "up" ]; then
	terraform -chdir="tf" init
	terraform -chdir="tf" apply -var-file="../${desired_service}/terraform.tfvars" -auto-approve

	if [ -e "${desired_service}/deploy.yaml" ]; then
		ansible-playbook -i "${desired_service}/inventory.proxmox.yml" "${desired_service}/deploy.yaml"
	fi
fi

if [ "$2" = "down" ]; then
	terraform -chdir="tf" destroy -var-file="../${desired_service}/terraform.tfvars" -auto-approve
fi
