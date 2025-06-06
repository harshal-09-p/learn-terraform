provider "vault" {
  address = "http://vault.harshaldevops.online:8200"
  token = var.token
}

variable "token" {}

data "vault_generic_secret" "rundeck_auth" {
  path = "demo/data/ssh"
}

