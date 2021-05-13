package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformGCPServiceAccount(t *testing.T) {
	t.Parallel()

	projectId := gcp.GetGoogleProjectIDFromEnvVar(t)

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "",

		Vars: map[string]interface{}{},

		EnvVars: map[string]string{
			"GOOGLE_CLOUD_PROJECT": projectId,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
