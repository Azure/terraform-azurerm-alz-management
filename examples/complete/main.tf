data "azurerm_client_config" "current" {}

resource "random_password" "management" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "management" {
  name     = "rg-terraform-azure-complete"
  location = "westeurope"
}

resource "azurerm_key_vault" "management" {
  name                        = "kv-${random_password.management.result}-azure"
  location                    = azurerm_resource_group.management.location
  resource_group_name         = azurerm_resource_group.management.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_key" "management" {
  name            = "generated-certificate"
  key_vault_id    = azurerm_key_vault.management.id
  key_type        = "RSA-HSM"
  key_size        = 2048
  expiration_date = "2024-07-06T20:00:00Z"


  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}

resource "azurerm_user_assigned_identity" "management" {
  location            = azurerm_resource_group.management.location
  name                = "id-terraform-azure"
  resource_group_name = azurerm_resource_group.management.name
}

module "management" {
  source = "../.."

  automation_account_name      = "aa-terraform-azure"
  location                     = "westeurope"
  log_analytics_workspace_name = "law-terraform-azure"
  resource_group_name          = azurerm_resource_group.management.name

  automation_account_encryption = {
    key_vault_key_id          = azurerm_key_vault_key.management.id
    user_assigned_identity_id = azurerm_user_assigned_identity.management.id
  }

  automation_account_identity = {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.management.id]
  }

  automation_account_local_authentication_enabled  = true
  automation_account_public_network_access_enabled = true
  automation_account_sku_name                      = "Basic"
  linked_automation_account_creation_enabled       = true

  log_analytics_solution_plans = [
    {
      product   = "OMSGallery/AgentHealthAssessment"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/AntiMalware"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/ChangeTracking"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/ContainerInsights"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/Security"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/SecurityInsights"
      publisher = "Microsoft"
    }
  ]

  log_analytics_workspace_allow_resource_only_permissions    = true
  log_analytics_workspace_cmk_for_query_forced               = true
  log_analytics_workspace_daily_quota_gb                     = 1
  log_analytics_workspace_internet_ingestion_enabled         = true
  log_analytics_workspace_internet_query_enabled             = true
  log_analytics_workspace_reservation_capacity_in_gb_per_day = 200
  log_analytics_workspace_retention_in_days                  = 50
  log_analytics_workspace_sku                                = "CapacityReservation"
  resource_group_creation_enabled                            = false

  tags = {
    environment = "dev"
  }

  tracing_tags_enabled = true
  tracing_tags_prefix  = "alz_"

}

