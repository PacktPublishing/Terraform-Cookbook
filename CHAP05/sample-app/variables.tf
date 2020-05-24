variable "resource_groupe_name" {
  description = "Resource groupe name"
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

variable "environement" {
  description = "Environement Name"
}


variable "custom_app_settings" {
  description = "Custom App settings"
  default     = {}
}

variable "createdby" {
  description = "name of the triggers user"
  default     = "NA"
}
