 resource "null_resource" "test" {
   count = 10
 }

 output "testprint" {
   value = null_resource.test
 }

 output "testprint2" {
   value = null_resource.test[*].id
 }

 resource "null_resource" "test1" { }

 output "test1print" {
   value = null_resource.test1.id
 }