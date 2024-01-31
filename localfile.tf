resource "local_file" "inventory" {
  filename = "/etc/ansible/hosts"
  file_permission  = "0644"

  content = templatefile("/home/allon/lesson14/lesson14/inventory.tpl", {
    #ip_addrs = google_compute_instance.andrdi-gcp-server[*].network_interface[0].access_config[0].nat_ip
    ip_addrs = yandex_compute_instance.vm-1.network_interface.0.ip_address
    #ip_addrs = yandex_compute_instance.vm-2.network_interface.0.ip_address
  })

 # provisioner "local-exec" {
  #  command = "ANSIBLE_CONFIG=${path.module}/../ansible/ansible.cfg ansible-playbook ${path.module}/../ansible/site.yml"
  #}
  }