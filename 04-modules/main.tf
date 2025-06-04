module "sample1" {
  source = "./sample"
  x = 100
}

variable "x" {
  default = 100
}

module "sample2" {
  source = "./sample"
  x = var.x
}
