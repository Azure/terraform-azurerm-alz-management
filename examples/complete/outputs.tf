output "test_automation_account_msi_principal_id" {
  description = "value of the MSI principal ID for the Azure Automation Account."
  value       = module.management.automation_account.identity.principal_id
}

output "test_automation_account_resource_id" {
  description = "value of the resource ID for the Azure Automation Account."
  value       = module.management.automation_account.id
}

output "test_log_analytics_workspace_resource_id" {
  description = "value of the resource ID for the Log Analytics Workspace."
  value       = module.management.log_analytics_workspace.id
}
