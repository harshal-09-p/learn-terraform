variable "x" {
    default = 10
}

output "print1" {
    value = var.x
}

variable "str" {
    default = "harsh"
}

variable "num" {
    default = 10  
}

variable "mybool" {
    default = true
}

output "str" {
    value = "${ var.str }, hello"
}
output "str2" {
    value = var.str
}

variable "a" {
    default = "this is a normal variable"
}

variable "b" {
    default = [
        1,
        2,
        "abc",
        true
    ]
}

variable "c" {
    default = {
        x = 10,
        y = 20,
        z = "abc"
    }
}

output "prlist" {
    value = var.b[1]
}

output "prmap" {
    value = var.c["y"]
}

variable "cli" { 
    default = 1
}

output "prcli" {
    value = var.cli
}

variable "v1" { }

output "prv1" {
    value = var.v1
}

variable "env" {}

output "prenv" {
    value = var.env
}