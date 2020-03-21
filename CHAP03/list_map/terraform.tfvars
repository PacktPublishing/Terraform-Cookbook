resource_groupe_name = "RG-App"
service_plan_name    = "Plan-App"
environement         = "DEV1"


web_apps = {
  webapp1 = {
    "name"                     = "webappdemobook1"
    "location"                 = "West Europe"
    "dotnet_framework_version" = "v4.0"
    "serverdatabase_name"      = "server1"
  },
  webapp2 = {
    "name"                     = "webapptestbook2"
    "dotnet_framework_version" = "v4.0"
    "serverdatabase_name"      = "server2"
  }
}