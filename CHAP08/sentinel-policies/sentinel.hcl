
module "tfplan-functions" {
  source = "https://raw.githubusercontent.com/hashicorp/terraform-guides/master/governance/third-generation/common-functions/tfplan-functions/tfplan-functions.sentinel"
}


policy "allowed-terraform-version" {
  source ="./allowed-terraform-version.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "allowed-app-service-plan-tiers"{
  source ="./allowed-app-service-plan-tiers.sentinel"
  enforcement_level = "hard-mandatory"
}