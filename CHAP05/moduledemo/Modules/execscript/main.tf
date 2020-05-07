resource "null_resource" "execfile" {
  provisioner "local-exec" {
    command     = "${path.module}/script.sh"
    interpreter = ["/bin/bash"]
  }
}