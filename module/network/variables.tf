variable "project" { type = string }
variable "vpc_name" { type = string }
variable "auto_subnets" { type = bool }
variable "subnetwork" { type = string }
variable "subnetwork_range" { type = string }
variable "region" { type = string }
variable "router_count" { type = bool }
variable "router_name" { type = string }
variable "asn" { type = number }
variable "nat_count" { type = bool }
variable "nat_name" { type = string }
variable "peering_count" { type = number }
variable "peering_name" { type = string }
variable "network_link" { type = string }
variable "peer_network_link" { type = string }

variable "firewall_rules" {
  type = list(object({
    name          = string
    network       = string
    project       = string
    protocol      = string
    ports         = list(number)
    source_ranges = list(string)
    target_tags   = list(string)
  }))
}
