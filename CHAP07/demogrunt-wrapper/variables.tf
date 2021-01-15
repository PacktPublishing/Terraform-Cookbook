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
}

variable "environment" {
  description = "Environment Name"
}


variable "custom_app_settings" {
  description = "Custom App settings"
  default     = {}
}

variable "createdby" {
  description = "name of the triggers user"
  default     = "NA"
}
