data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aks" {
  name                        = "kv-k8szone"
  location                    = azurerm_resource_group.aks.location
  resource_group_name         = azurerm_resource_group.aks.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Purge"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "kubeconfig" {
  name         = "kubeconfig"
  value        = azurerm_kubernetes_cluster.aks.kube_config_raw
  key_vault_id = azurerm_key_vault.aks.id
}

resource "azurerm_key_vault_secret" "client_certificate" {
  name         = "clientcertificate"
  value        = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  key_vault_id = azurerm_key_vault.aks.id
}