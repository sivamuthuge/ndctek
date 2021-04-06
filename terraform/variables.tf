variable "project" {
}

variable "region" {
  default = "europe-west2"
}

variable "project_services" {
  type = list(string)
  default = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}

variable "cluster_name" {
  default = "test"
}

variable "cluster_zone" {
  default = "europe-west2-b"
}

variable "additional_zones" {
  type    = list(string)
  default = []
}

variable "cluster_nodes" {
  default = "1"
}

variable "cluster_node_type" {
  default = "n1-standard-2"
}

variable "kubernetes_network_ipv4_cidr" {
  type        = string
  default     = "10.0.96.0/22"
}

variable "kubernetes_pods_ipv4_cidr" {
  default = "10.0.92.0/22"
}

variable "kubernetes_services_ipv4_cidr" {
  default = "10.0.88.0/22"
}
