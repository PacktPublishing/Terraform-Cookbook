resource_group_name = "RG-App"
service_plan_name    = "Plan-App"
environment         = "DEV1"


nb_webapp = 2

tags = {
  ENV          = "DEV1"
  CODE_PROJECT = "DEMO"
}

custom_app_settings = {
  CUSTOM_KEY1 = "CUSTOM_VAL1"
}
