
resource "nebius_compute_disk" "nfs" {
  name       = "nfs-disk"
  type       = "network-ssd-io-m3"
  zone       = var.region
  size       = var.nfs_size

}


resource "nebius_compute_instance" "nfs_server" {
  name           = "nfs-share"
  platform_id    = "standard-v2"
  zone           = "eu-north1-c"
  
  resources {
    cores  = "16"
    memory = "32"
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = "93"
      type = "network-ssd-io-m3"
    }
  }

  secondary_disk {
      disk_id = nebius_compute_disk.nfs.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = templatefile(
      "./files/cloud-config.yaml.tftpl", {
        nfs_ip_range  = var.nfs_ip_range
        nfs_path      = var.nfs_path
        mtu_size      = var.mtu_size
        user          = var.username
        sshkey        = var.sshkey
      })
  }
}

