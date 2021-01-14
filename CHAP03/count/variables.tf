variable "resource_group_name" {
  description = "Resource group name"
}

variable "location" {
  description = "Location of Azure reource"
  default     = "West Europe"
}

variable "service_plan_name" {
  description = "Service plan name"
}


variable "app_name" {
  description = "Name of application"
  default     = "MyApp"
}

variable "environment" {
  description = "Environment Name"
}


variable "nb_webapp" {
  description = "Number of web App to create"
}

