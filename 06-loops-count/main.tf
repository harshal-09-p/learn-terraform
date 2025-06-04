 resource "null_resource" "test" {
   count = 10
 }

 output "testprint" {
   value = null_resource.test
 }