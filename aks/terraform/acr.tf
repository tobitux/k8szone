resource "azurerm_container_registry" "k8szone" {
  name                = "crk8szone"
  resource_group_name = azurerm_resource_group.k8szone.name
  location            = azurerm_resource_group.k8szone.location
  sku                 = "Basic"
  admin_enabled       = false
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.k8szone.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8szone.kubelet_identity[0].object_id
}