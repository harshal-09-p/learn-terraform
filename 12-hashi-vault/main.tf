provider "vault" {
  address = "http://vault.harshaldevops.online:8200"
  token = var.token
}

variable "token" {}

data "vault_generic_secret" "secret" {
  path = "demo/ssh"
}

resource "local_file" "file1" {
  content = jsondecode(data.vault_generic_secret.secret.data)
  filename = "/tmp/vault"
}

resource "local_file" "file2" {
  content = data.vault_generic_secret.secret.data_json["password"]
  filename = "/tmp/vault-pass"
}