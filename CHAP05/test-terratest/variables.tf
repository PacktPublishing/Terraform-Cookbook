variable "raw_string_list" {
  type        = list(string)
  description = ""
  default     = ["us-west-1a", "us-west-1b", "us-west-1c"]
}

variable "permutation_count" {
  description = ""
  default     = 1
}
