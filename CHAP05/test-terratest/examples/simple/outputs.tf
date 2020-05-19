output "output_list" {
  description = "The result of the random_shuffle module"
  value       = module.random_shuffle.permutation_string_list
}
