provider "null" {
}

resource "null_resource" "test"{
}

resource "null_resource" "test2"{
}

output "print"{
    value = resource.test
}

output "print1"{
    value = resource.test1.id
}