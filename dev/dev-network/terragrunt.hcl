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

  vpc_name = "ansible-dev"
  auto_subnets = false
 
  subnetwork = "sub-1"
  subnetwork_range = "10.4.0.0/16"
  
  firewall_rules = [
    {
      name          = "secure-ssh-admin"
      network       = "ansible-dev"
      project       = local.project.project_id
      protocol      = "tcp"
      ports         = [22]
      source_ranges = ["35.235.240.0/20"] # # Identity Aware Proxy TCP forwarding ssh access
      target_tags   = ["mgmt"]
    },
     {
      name          = "ansible-master-access-dev"
      network       = "ansible-dev"
      project       = local.project.project_id
      protocol      = "tcp"
      ports         = [22]
      source_ranges = [""] # ssh access to ansible dev from master - add master vm ip
      target_tags   = ["mgmt"]
    },
    {
      name          = "ansible-web-traffic"
      network       = "ansible-dev"
      project       = local.project.project_id
      protocol      = "tcp"
      ports         = [80,443]
      source_ranges = ["0.0.0.0/0"] # all web traffic + ports to view dev ansible web page
      target_tags   = ["mgmt"]
    },
  ]

 router_count = false
 router_name = false
 asn = 0

 nat_count = false
 nat_name = false

 peering_count = 1
 peering_name = "peer-2"

 network_link = "projects/{your_project}/global/networks/{your_network}" 
 peer_network_link = "projects/{peering_project}/global/networks/{peering_network}"
