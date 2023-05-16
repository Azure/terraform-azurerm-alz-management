module "management" {
  source                           = "../.."
  resource_group_name              = "rg-terraform-azure"
  log_analytics_workspace_name     = "law-terraform-azure"
  automation_account_name          = "aa-terraform-azure"
  location                         = "eastus"
  deploy_linked_automation_account = false
}

