resource "google_compute_instance" "cloud_vm" {
  name         = var.name
  machine_type = var.machine_type 
  zone         = var.zone
  project = var.project
  deletion_protection = var.deletion_protection
  tags = var.tags
  boot_disk {
    auto_delete = var.auto_delete
    initialize_params {
      image = var.image 
      size  = var.disk_size
      type  = var.disk_type
    }
  }
  network_interface {
    network = var.network
    subnetwork = var.subnetwork

   dynamic "access_config" {
    for_each = var.assign_public_ip ? [1] : []
    content {
    }
  }
}
  metadata_startup_script = var.metadata_startup_script
}

