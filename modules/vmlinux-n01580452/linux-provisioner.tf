 resource "null_resource" "vmlinux-n01580452-provisioner-linux" {
     provisioner "local-exec" {
       command = "ansible-playbook -i /Users/babanjot/humber/automation/assignment-2/ansible/hosts --private-key /Users/babanjot/,ssh/id_rsa  /Users/babanjot/humber/automation/assignment-2/ansible/playbook.yaml"
     }
     depends_on = [ azurerm_linux_virtual_machine.n01580452-vmlinux ]
 }