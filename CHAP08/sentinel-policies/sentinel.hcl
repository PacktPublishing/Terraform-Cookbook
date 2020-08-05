
module "tfplan-functions" {
  source = "https://raw.githubusercontent.com/hashicorp/terraform-guides/master/governance/third-generation/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

policy "allowed-app-service-plan-tiers"{
  source ="./allowed-app-service-plan-tiers.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "allowed-app-service-to-ftps"{
  source ="./restrict-app-service-to-ftps.sentinel"
  enforcement_level = "hard-mandatory"
}