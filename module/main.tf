
resource "google_service_account" "default" {
  account_id   = var.account_id
  display_name = var.display_name
  project = var.project
  
} 

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

  // Local SSD disk
  #scratch_disk {
   # interface = "SCSI"
  #}

  network_interface {
    network = var.network

    access_config {
      // Ephemeral public IP
    }
  }


  metadata_startup_script = var.metadata_startup_script


}

