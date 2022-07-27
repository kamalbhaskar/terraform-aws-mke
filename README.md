# Bootstrapping MKE cluster over AWS using Terraform
Terraform scripts/modules to bootstrap an MKE cluster over AWS
## Prerequisites
- An account and IAM credentials for AWS.
- Terraform [installed and configured](https://learn.hashicorp.com/terraform/getting-started/install).

## Steps
1. Export AWS credentials as a profile.

2. Update the "terraform.tfvars" file with the input values for required variables.

3. Then, Execute the below commands from the repo root directory to initialize & validate the inputs, before deployment:
```
terraform init
terraform plan -var-file="terraform.tfvars"
```

4. Finally, Execute below command from the repo root directory to deploy the configuration:
```
terraform apply -var-file="terraform.tfvars"
```
