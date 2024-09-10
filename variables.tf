variable "agent_count" {
  default = 2
}

variable "admin_username" {
  default = "demo"
}

variable "cluster_name" {
  default = "demok8s"
}

variable "log_analytics_workspace_location" {
  default = "West Europe"
}

variable "log_analytics_workspace_name" {
  default = "testLogAnalyticsWorkspaceName"
}


variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "resource_group_location" {
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "demo-terraform-kubernetes-RG"
  description = "Resource group name that is unique in your Azure subscription."
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

# nodes will be part of this Ingress namespace 
variable "namespace" {
   default = "ingress-basic"
}

variable "cert_manager_version" {
  default = "v1.12.0"
}
variable "dns_prefix" {
   default = "kada"
}

variable "Ingress_script_path" {
   default = "./setup_ingress.sh"
}
/* variable "aks_service_principal_app_id" {
  default = "<>"
}

variable "aks_service_principal_client_secret" {
  default = "K<>"
} */
