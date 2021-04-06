data "google_container_engine_versions" "versions" {
  location       = "europe-west2"
}

resource "google_container_cluster" "cluster" {
  provider           = google-beta
  name               = var.cluster_name
  location           = var.primary_zone
  description        = var.description
  initial_node_count = var.node_count
  node_locations     = var.additional_zones
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  enable_legacy_abac = "false"
  node_version       = data.google_container_engine_versions.versions.latest_master_version
  min_master_version = data.google_container_engine_versions.versions.latest_master_version
  network             = var.network
  subnetwork          = var.subnetwork
  remove_default_node_pool = true

  addons_config {
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled = true
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum = 1
      maximum = 10
    }
    resource_limits {
      resource_type = "memory"
      minimum = 1
      maximum = 10
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_rangename
    services_secondary_range_name = var.services_rangename
  }

}