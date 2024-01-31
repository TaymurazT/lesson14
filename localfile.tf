resource "local_file" "inventory" {
  filename = "/etc/ansible/hosts"
  file_permission  = "0644"

  content = templatefile("/home/allon/lesson14/lesson14/inventory.tpl", {
    addr1 = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
    addr2 = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
  })

 # provisioner "local-exec" {
  #  command = "ANSIBLE_CONFIG=${path.module}/../ansible/ansible.cfg ansible-playbook ${path.module}/../ansible/site.yml"
  #}
  }