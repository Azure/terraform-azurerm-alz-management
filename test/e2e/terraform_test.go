package e2e

import (
	"regexp"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamplesBasic(t *testing.T) {
	test_helper.RunE2ETest(t, "../../", "examples/basic", terraform.Options{
		Upgrade: true,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		logAnalyticsId, ok := output["test_log_analytics_workspace_resource_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.OperationalInsights/workspaces/.+"), logAnalyticsId)
		resourceGroupId, ok := output["test_resource_group_resource_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+"), resourceGroupId)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Automation/automationAccounts/.+"), output["test_automation_account_resource_id"])
	})
}

func TestExamplesComplete(t *testing.T) {
	test_helper.RunE2ETest(t, "../../", "examples/complete", terraform.Options{
		Upgrade: true,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		logAnalyticsId, ok := output["test_log_analytics_workspace_resource_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.OperationalInsights/workspaces/.+"), logAnalyticsId)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Automation/automationAccounts/.+"), output["test_automation_account_resource_id"])
		automationAccountMsiId, ok := output["test_automation_account_msi_principal_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"), automationAccountMsiId)
	})
}
