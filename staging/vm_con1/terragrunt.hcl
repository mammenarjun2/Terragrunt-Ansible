include {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "/workspaces/terragrunt//module"
}

locals {
   default_yaml_path = "root.yaml"
   project = yamldecode(file(find_in_parent_folders("root.yaml", local.default_yaml_path)))
}

inputs = {
  account_id   = "terraformnewaccess"
  display_name = "google_service_account"
  name = "terraform-new-instance"
  machine_type = "e2-small"
  disk_size = 20
  disk_type = "pd-ssd"
  region = "europe-west1"
  image = "debian-cloud/debian-10"
  network = "default"
  metadata_startup_script = "echo hi > /test.text"  
  deletion_protection = false
  project = local.project.project_id
}