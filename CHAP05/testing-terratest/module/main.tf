variable "string1" {
}

variable "string2" {
}


## PUT YOUR MODULE CODE

output "stringfct" {
  value = format("This is test of %s with %s", var.string1, upper(var.string2))
}