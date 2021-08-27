resource "azurerm_resource_group" "k8szone" {
  name     = "rg-k8szone"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "k8szone" {
  name                = "aks-k8szone"
  location            = azurerm_resource_group.k8szone.location
  resource_group_name = azurerm_resource_group.k8szone.name
  dns_prefix          = "aks-k8szone-dns"

  node_resource_group = "rg-k8szone-nodes"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  role_based_access_control {
    enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Test"
  }
}

resource "local_file" "kubeconfig" {
    sensitive_content  = azurerm_kubernetes_cluster.k8szone.kube_config_raw
    filename = "${pathexpand("~/.kube/k8szone")}"
    file_permission = "0600"
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8szone.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8szone.kube_config_raw
  sensitive = true
}