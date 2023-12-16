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

  name = "ansible-dev"
  machine_type = "e2-small"
  disk_size = 20
  disk_type = "pd-ssd"
  zone = "us-central1-a"
  image = "ubuntu-os-cloud/ubuntu-2004-lts"
  network = "ansible-dev"
  subnetwork ="projects/{your_project}/regions/{your_region}/subnetworks/{your_subnetwork}"
  access_config = {}
  deletion_protection = false
  metadata_startup_script = ""
  assign_public_ip= true
  tags = ["mgmt"]
}