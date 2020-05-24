resource "random_shuffle" "rs" {
  input        = var.raw_string_list
  result_count = var.permutation_count
}
