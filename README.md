# TERRAFORM_AKS
In this, we will create an AKS cluster and deploy a demo web application on it. Prerequisites: AzureCli, Terraform, Helm, kubectl

1. Create a Storage account to store terraform statefile
2. Setup the environment and create an Azure resource group - Terraform
3. The AKS cluster creation will use AzureCNI/Kubenet networking - Kubenet.
4. RBAC enabled - Enabled while creating the AKS cluster via Terraform script.
5. Implement a Kubernetes Ingress Controller like Nginx Ingress or Azure Application Gateway Ingress Controller to manage incoming HTTPS traffic. NGINX ingress controller
6. Provision SSL/TLS certificates using Azure Key Vault or a trusted certificate provider. Used letsencrypt and cert-manager.
7. Configure Ingress resources to route incoming HTTPS traffic to your web application pods. Created the ingress.
8. Create Kubernetes deployment and service resources for your application. Used demo application Yaml files.
9. Enable Container insights monitoring for the AKS cluster. - Enabled while creating the AKS cluster via Terraform script.

Steps to run:
terraform init
terraform plan
terraform apply

Also, api_server_access_profile is commented 
And the backend is commented in providers.tf file.
In case you want to use an Azure storage account as a backend then feel free to uncomment. The script to create the storage account with the name "createStorageAccount.sh" in the folder, you can run the script before running terraform init.
