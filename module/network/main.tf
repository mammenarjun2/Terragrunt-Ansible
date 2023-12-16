
resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_subnets
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork
  ip_cidr_range = var.subnetwork_range
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "firewall" {
  count = length(var.firewall_rules)

  name    = var.firewall_rules[count.index].name
  network = var.firewall_rules[count.index].network
  project = var.firewall_rules[count.index].project

  allow {
    protocol = var.firewall_rules[count.index].protocol
    ports    = var.firewall_rules[count.index].ports
  }

  source_ranges = var.firewall_rules[count.index].source_ranges

  target_tags = var.firewall_rules[count.index].target_tags

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_router" "router" {
  count   = var.router_count ? 1 : 0
  name    = var.router_name
  project = var.project
  region  = google_compute_subnetwork.subnetwork.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = var.router_count ? var.asn : null
  }
}

resource "google_compute_router_nat" "nat" {
  count                              = var.nat_count ? 1 : 0
  name                               = var.nat_name
  project                            = var.project
  router                             = google_compute_router.router[0].name
  region                             = google_compute_router.router[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"


}

resource "google_compute_network_peering" "peeringluc" {
  count        = var.peering_count 
  name         = "${var.peering_name}-${count.index + 1}"
  network      = var.network_link
  peer_network = var.peer_network_link
}