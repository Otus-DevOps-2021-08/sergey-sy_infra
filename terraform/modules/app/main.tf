resource "random_pet" "pet" {
  //      byte_length = 8
}

resource "yandex_compute_instance" "app" {
  count = var.count_resources
  name  = "reddit-app-${count.index}-${random_pet.pet.id}"

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "local-exec" {
    command = "echo 'DATABASE_URL=${var.database_url}:27017' > ${path.module}/files/app_env.conf.tmp"
  }

  provisioner "file" {
    source      = "${path.module}/files/app_env.conf.tmp"
    destination = "/tmp/app_env.conf"
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

}

