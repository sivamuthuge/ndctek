
provider "google" {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

data "google_project" "gcp-project" {
  project_id = var.project
}

resource "google_project_service" "service" {
  count   = length(var.project_services)
  project = var.project
  service = element(var.project_services, count.index)
  disable_on_destroy = false
}

resource "google_compute_network" "network" {
  name = "gke-network"
  project = var.project
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
  name = "gke-subnetwork"
  project = var.project
  network = google_compute_network.network.self_link
  ip_cidr_range = var.kubernetes_network_ipv4_cidr
  region = var.region
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.kubernetes_pods_ipv4_cidr
  }

  secondary_ip_range {
    range_name    = "gke-svcs"
    ip_cidr_range = var.kubernetes_services_ipv4_cidr
  }
}

module "cluster" {
  source              = "./modules/gke"
  cluster_name        = var.cluster_name
  primary_zone        = var.cluster_zone
  additional_zones    = var.additional_zones
  node_count          = var.cluster_nodes
  machine_type        = var.cluster_node_type
  disk_size           = "20"
  network             = google_compute_network.network.self_link
  subnetwork          = google_compute_subnetwork.subnetwork.self_link
  pods_rangename      = google_compute_subnetwork.subnetwork.secondary_ip_range[0].range_name
  services_rangename  = google_compute_subnetwork.subnetwork.secondary_ip_range[1].range_name
}
