input {
  resource_group_name = "rg-demo-dev"
  subnet_name = "subnetDev"
  vnet_name = "VnetDev"
}


dependencies {
  paths = ["../rg", "../network"]
}