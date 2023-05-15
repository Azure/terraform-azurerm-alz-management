output "automation_account_resource_id" {
  description = "value of the resource ID for the Azure Automation Account."
  value       = try(azurerm_automation_account.management[0].id, null)
}

output "automation_account_msi_prinicpal_id" {
  description = "value of the MSI principal ID for the Azure Automation Account."
  value       = try(azurerm_automation_account.management[0].identity[0].principal_id, null)
}

output "log_analytics_workspace_resource_id" {
  description = "value of the resource ID for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.management.id
}

output "resource_group_resource_id" {
  description = "value of the resource ID for the Azure Resource Group."
  value       = try(azurerm_resource_group.management[0].id, null)
}


