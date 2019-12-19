resource "sakuracloud_ssh_key" "mykey" {
  name        = var.sshkey["name"]
  public_key  = file(var.ssh_pubkey_path)
  description = var.sshkey["memo"]
}
