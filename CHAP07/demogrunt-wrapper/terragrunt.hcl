terraform {

# Pass custom init option to Terraform
  extra_arguments "custom_backend" {
    commands = [
      "init"
    ]

    arguments = [
      "-backend-config", "backend.tfvars"
    ]
  }

  # Pass custom var files to Terraform
  extra_arguments "custom_vars-file" {
    commands = [
      "apply",
      "plan",
      "destroy",
      "refresh"
    ]

    arguments = [
      "-var-file", "env-vars.tfvars"
    ]
  }
  

}