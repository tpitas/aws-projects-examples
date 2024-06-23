Please follow the instructions below for deploying resources to AWS 
- terraform -chdir=terraform init --input=false
- terraform -chdir=terraform plan --input=false --var-file=prod.tfvars
- terraform -chdir=terraform apply --input=false --var-file=prod.tfvars

if you want to delete all resources created
- terraform -chdir=terraform destroy --input=false --var-file=prod.tfvars