resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../mytextfile.txt"
}

resource "null_resource" "readcontentfile" {

  triggers = {
        trigger = timestamp()
  }

  provisioner "local-exec" {
    command = "Get-Content -Path ../mytextfile.txt" 

    interpreter = ["PowerShell", "-Command"]
  }
}