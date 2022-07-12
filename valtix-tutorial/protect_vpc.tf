###################################
# 2c. VPC Peering
###################################
data "google_compute_network" "spoke_network" {
  name = "valtix-demo-production-network"
}

# VPC Peering between Spoke VPC and Service VPC
resource "valtix_spoke_vpc" "valtix_spoke" {
  service_vpc_id = valtix_service_vpc.service_vpc.id
  spoke_vpc_id   = data.google_compute_network.spoke_network.id
  depends_on     = [valtix_gateway.gcp-gw1]
}

# Orchestrate route for Spoke VPC traffic to be inspected by Valtix
resource "google_compute_route" "production_to_valtix" {
  name         = "route-spoke-to-valtix"
  dest_range   = "0.0.0.0/0"
  network      = data.google_compute_network.spoke_network.name
  next_hop_ilb = valtix_gateway.gcp-gw1.gateway_endpoint
  priority     = 950
  depends_on   = [valtix_spoke_vpc.valtix_spoke]
}