package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformModule(t *testing.T) {
	terraformOptions := &terraform.Options{
		// path to the terraform code
		TerraformDir: "./fixture",
	}

	// lean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	output := terraform.Output(t, terraformOptions, "outmodule")
	assert.Equal(t, "This is test of module with TERRATEST", output)
}
