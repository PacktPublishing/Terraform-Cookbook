terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "demoBook"

    workspaces {
      name = "demo-app"
    }
  }
}



resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
