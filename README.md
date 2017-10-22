# terraform-opendev-core
Core Kubernetes cluster for Microsoft OpenDev presentation.

## Setup
Set the environment variables for your Azure account.  

```bash
# Azure settings
export TF_VAR_subscription_id="xxxxxxxx"
export TF_VAR_client_id="xxxxxxxx"
export TF_VAR_client_secret="xxxxxxxxx"
export TF_VAR_tenant_id="xxxxxxxxx"

# FOR REMOTE STORAGE ACCOUNT
export ARM_ACCESS_KEY="xxxxxxxxx"
```

Create a new SSH Key to add to the server, if you do not use the default location
of ~/.ssh/server_rsa then you will need to update `variables.tf` with the key paths.  

```bash
ssh-keygen -t rsa -b 4096 -P "" -f ~/.ssh/server_rsa
```

## Running
Run `terraform init` to initialise Terraform and fetch providers  
Run `terraform plan` to check for changes  
Run `terraform apply` to apply changes  
