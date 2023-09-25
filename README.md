# TERRAFORM_AKS
In this, we will create an AKS cluster and deploy a demo web application on it. Prerequisites: AzureCli, Terraform, Helm, kubectl

Create a Storage account to store terraform statefile
Setup the environment and create an Azure resource group - Terraform
The AKS cluster creation will use AzureCNI/Kubenet networking - Kubenet.
RBAC enabled - Enabled while creating the AKS cluster via Terraform script.
Implement a Kubernetes Ingress Controller like Nginx Ingress or Azure Application Gateway Ingress Controller to manage incoming HTTPS traffic. NGINX ingress controller
Provision SSL/TLS certificates using Azure Key Vault or a trusted certificate provider. Used letsencrypt and cert-manager.
Configure Ingress resources to route incoming HTTPS traffic to your web application pods. Created the ingress.
Create Kubernetes deployment and service resources for your application. Used demo application Yaml files.
Enable Container insights monitoring for the AKS cluster. - Enabled while creating the AKS cluster via Terraform script.
