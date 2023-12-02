terraform {
  source = "/workspaces/terragrunt//module"
}

include {
  path = find_in_parent_folders("common.hcl")
}

locals {
   default_yaml_path = "root.yaml"
   project = yamldecode(file(find_in_parent_folders("root.yaml", local.default_yaml_path)))
}

inputs = {
  account_id   = "ansibleaccess"
  display_name = "google_service_account_master"
  name = "ansible-instance-master"
  machine_type = "e2-small"
  disk_size = 20
  disk_type = "pd-ssd"
  zone = "us-central1-a"
  image = "debian-cloud/debian-10"
  network = "default"
  metadata_startup_script = "echo hi > /test.text"  
  deletion_protection = false
  project = local.project.project_id
}