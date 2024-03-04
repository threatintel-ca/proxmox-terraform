# Preparing to Run deploy.sh

Before executing the `deploy.sh` script to provision resources, ensure you've completed the following steps:

## 1. Create `terraform.tfvars` File

Generate a file named `terraform.tfvars` in the project root. This file will contain the necessary variable values required by Terraform for provisioning.

## 2. Open `variables`

Using your preferred text editor or command-line interface, modify `variables` with your desired values.

## 3. Running `deploy.sh`

```
<path_to>/deploy.sh k3s up
```

# Teardown

```
<path_to>/deploy.sh k3s down
```
