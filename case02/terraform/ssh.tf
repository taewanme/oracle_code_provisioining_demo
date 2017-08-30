resource "opc_compute_ssh_key" "sshkey01" {
  name    = "sshkey01"
  key     = "${file(var.ssh_public_key_file)}"
  enabled = true
}
