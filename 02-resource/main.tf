provider "null" {
}

resource "null_resource" "test"{
}

resource "null_resource" "test2"{
}

output "print"{
    value = null_resource.test
}

output "print1"{
    value = null_resource.test1.id
}