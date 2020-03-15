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


variable "nb_webapp" {
  description = "Number of web App to create"
}

