variable "demo" {
  default = true
}

variable "demo1" {
  default = false
}

resource "null_resource" "demo" {
 count = var.demo ? 1 : 0  
}

resource "null_resource" "demo1" {
  count = var.demo ? 1: 0 
}