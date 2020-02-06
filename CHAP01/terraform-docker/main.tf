resource "random_string" "random" {
  length = 16
}

output "random"{
    value =random_string.random.result
}