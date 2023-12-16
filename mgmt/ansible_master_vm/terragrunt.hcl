terraform {
  source = "/workspaces/terragrunt//module/compute"
}

include {
  path = find_in_parent_folders("common.hcl")
}

locals {
   default_yaml_path = "root.yaml"
   project = yamldecode(file(find_in_parent_folders("root.yaml", local.default_yaml_path)))
}


inputs = {

  project = local.project.project_id 
 
  name = "ansible-instance-master"
  machine_type = "e2-small"
  disk_size = 20
  disk_type = "pd-ssd"
  zone = "us-central1-a"
  image = "ubuntu-os-cloud/ubuntu-2004-lts"
  network = "ansible-mgmt"
  subnetwork = "projects/{your_project}/regions/{your_region}/subnetworks/{your_subnetwork}"
  metadata_startup_script = file("script/bash.sh")
  deletion_protection = true
  tags = ["mgmt"]
  assign_public_ip= false
}
