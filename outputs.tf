output "automation_account" {
  description = "A curated output of the Azure Automation Account."
  value = {
    dsc_primary_access_key   = try(azurerm_automation_account.management[0].dsc_primary_access_key, null)
    dsc_secondary_access_key = try(azurerm_automation_account.management[0].dsc_secondary_access_key, null)
    dsc_server_endpoint      = try(azurerm_automation_account.management[0].dsc_server_endpoint, null)
    hybrid_service_url       = try(azurerm_automation_account.management[0].hybrid_service_url, null)
    id                       = try(azurerm_automation_account.management[0].id, null)
    name                     = try(azurerm_automation_account.management[0].name, null)
    identity = {
      tenant_id    = try(azurerm_automation_account.management[0].identity[0].tenant_id, null)
      principal_id = try(azurerm_automation_account.management[0].identity[0].principal_id, null)
    }
  }
}

output "log_analytics_workspace" {
  description = "A curated output of the Log Analytics Workspace."
  value = {
    id                   = azurerm_log_analytics_workspace.management.id
    name                 = azurerm_log_analytics_workspace.management.name
    primary_shared_key   = azurerm_log_analytics_workspace.management.primary_shared_key
    secondary_shared_key = azurerm_log_analytics_workspace.management.secondary_shared_key
    workspace_id         = azurerm_log_analytics_workspace.management.workspace_id
  }
}

output "resource_group" {
  description = "A curated output of the Azure Resource Group."
  value = {
    id   = try(azurerm_resource_group.management[0].id, null)
    name = try(azurerm_resource_group.management[0].name, null)
  }
}
