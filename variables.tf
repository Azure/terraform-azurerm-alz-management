variable "automation_account_name" {
  type        = string
  description = "The name of the Azure Automation Account to create."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the Log Analytics Workspace to create."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where the resources will be created."
}

variable "automation_account_encryption" {
  type = object({
    key_vault_key_id          = string
    user_assigned_identity_id = optional(string, null)
  })
  default     = null
  description = "The encryption configuration for the Azure Automation Account."
}

variable "automation_account_identity" {
  type = object({
    type         = string
    identity_ids = optional(set(string), null)
  })
  default     = null
  description = "The identity to assign to the Azure Automation Account."
}

variable "automation_account_local_authentication_enabled" {
  type        = bool
  default     = true
  description = "Whether or not local authentication is enabled for the Azure Automation Account."
}

variable "automation_account_public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Whether or not public network access is enabled for the Azure Automation Account."
}

variable "automation_account_sku_name" {
  type        = string
  default     = "Basic"
  description = "The name of the SKU for the Azure Automation Account to create."
}

variable "linked_automation_account_creation_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to determine whether to deploy the Azure Automation Account linked to the Log Analytics Workspace or not."
}

variable "log_analytics_solution_plans" {
  type = list(object({
    product   = string
    publisher = optional(string, "Microsoft")
  }))
  default = [
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
    },
    {
      product   = "OMSGallery/ServiceMap"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/SQLAdvancedThreatProtection"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/SQLAssessment"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/SQLVulnerabilityAssessment"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/Updates"
      publisher = "Microsoft"
    },
    {
      product   = "OMSGallery/VMInsights"
      publisher = "Microsoft"
    },
  ]
  description = "The Log Analytics Solution Plans to create."
}

variable "log_analytics_workspace_allow_resource_only_permissions" {
  type        = bool
  default     = false
  description = "Whether or not to allow resource-only permissions for the Log Analytics Workspace."
}

variable "log_analytics_workspace_cmk_for_query_forced" {
  type        = bool
  default     = null
  description = "Whether or not to force the use of customer-managed keys for query in the Log Analytics Workspace."
}

variable "log_analytics_workspace_daily_quota_gb" {
  type        = number
  default     = null
  description = "The daily ingestion quota in GB for the Log Analytics Workspace."
}

variable "log_analytics_workspace_internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "Whether or not internet ingestion is enabled for the Log Analytics Workspace."
}

variable "log_analytics_workspace_internet_query_enabled" {
  type        = bool
  default     = true
  description = "Whether or not internet query is enabled for the Log Analytics Workspace."
}

variable "log_analytics_workspace_reservation_capacity_in_gb_per_day" {
  type        = number
  default     = null
  description = "The reservation capacity in GB per day for the Log Analytics Workspace."
}

variable "log_analytics_workspace_retention_in_days" {
  type        = number
  default     = 30
  description = "The number of days to retain data for the Log Analytics Workspace."
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "The SKU to use for the Log Analytics Workspace."
}

variable "resource_group_creation_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to determine whether to deploy the Azure Resource Group or not."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to the resources created."
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_enabled" {
  type        = bool
  default     = false
  description = "Whether enable tracing tags that generated by BridgeCrew Yor."
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "tracing_tags_prefix" {
  type        = string
  default     = "avm_"
  description = "Default prefix for generated tracing tags"
  nullable    = false
}
