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

variable "nb_webapp" {
  description = "Number of web App to create"
}

variable "app_name" {
  description = "Name of application"
  default     = "MyApp"
}

variable "environement" {
  description = "Environement Name"
}

variable "createdby" {
  description = "name of the triggers user"
  default     = "NA"
}


variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}


variable "custom_app_settings" {
  description = "Custom app settings"
  type = map(string)
  default     = {}

}
