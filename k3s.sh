if [ "$1" = "up"]; then
	terraform -chdir="tf" init
	cp terraform.tfvars tf/terraform.tfvars
	terraform -chdir="tf" apply -var-file="./k3s/terraform.tfvars"
fi
