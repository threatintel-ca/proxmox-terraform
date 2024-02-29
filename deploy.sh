terraform -chdir="tf" init
cp terraform.tfvars tf/terraform.tfvars
terraform -chdir="tf" apply -var-file="terraform.tfvars"
