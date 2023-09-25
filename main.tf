resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
/*   provisioner "local-exec" {
    command = "sh createStorageAccount.sh"
  } */
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
  location            = var.log_analytics_workspace_location
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
  location              = azurerm_log_analytics_workspace.test.location
  resource_group_name   = azurerm_resource_group.rg.name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.test.name
  workspace_resource_id = azurerm_log_analytics_workspace.test.id

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  role_based_access_control_enabled = true
  tags = {
    Environment = "Development"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.agent_count
  }
  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  /*    service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }  */
  identity {
    type = "SystemAssigned"
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }
/*   api_server_access_profile {
    authorized_ip_ranges = ["CIDR RANGE"]
  } */
}
 resource "null_resource" "setdefaultcluster" {
   provisioner "local-exec" {
      command = "az aks get-credentials --overwrite-existing --name ${var.cluster_name} --resource-group ${var.resource_group_name}"
   }
   depends_on = [azurerm_kubernetes_cluster.k8s]  
} 

resource "null_resource" "setingress" {
   provisioner "local-exec" {
      command = "sh ${var.Ingress_script_path} ${var.namespace} ${var.dns_prefix} ${var.cert_manager_version}"
   }
   depends_on = [null_resource.setdefaultcluster]
} 