terraform {
  source = "/workspaces/terragrunt/module//network"
}

include {
  path = find_in_parent_folders("common.hcl")
}

locals {
   default_yaml_path = "root.yaml"
   project = yamldecode(file(find_in_parent_folders("root.yaml", local.default_yaml_path)))
   region = yamldecode(file(find_in_parent_folders("root.yaml", local.default_yaml_path)))
}

inputs = {

  project = local.project.project_id
  region = local.region.region

  vpc_name = "ansible-mgmt"
  auto_subnets = false
 
  subnetwork = "sub-1"
  subnetwork_range = "10.2.0.0/16"
  
  firewall_rules = [
    {
      name          = "secure-ssh-admin"
      network       = "ansible-mgmt"
      project       = local.project.project_id
      protocol      = "tcp"
      ports         = [22]
      source_ranges = ["35.235.240.0/20"] # Identity Aware Proxy TCP forwarding ssh access
      target_tags   = ["mgmt"]
    },
  ]

 router_count = true 
 router_name = "net-router"
 asn = 64514
 
 nat_count = true
 nat_name = "external-nat"

 peering_count = 1
 peering_name = "peer-1"

 network_link = "projects/{your_project}/global/networks/{your_network}" 
 peer_network_link = "projects/{peering_project}/global/networks/{peering_network}"
}
