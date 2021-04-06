variable "cluster_name" {
}

variable "description" {
  default = ""
}

variable "primary_zone" {
}

variable "node_count" {
  default = "1"
}

variable "additional_zones" {
  type    = list(string)
  default = []
}

variable "kubernetes_master_authorized_networks" {
  type = list(object({
    display_name = string
    cidr_block   = string
  }))

  default = [
    {
      display_name = "MasterAuthNetwork"
      cidr_block   = "10.0.96.0/22"
    },
  ]
  description = "List of CIDR blocks to allow access to the master's API endpoint. This is specified as a slice of objects, where each object has a display_name and cidr_block attribute. The default behavior is to allow anyone (0.0.0.0/0) access to the endpoint. You should restrict access to external IPs that need to access the cluster."
}

variable "machine_type" {
}

variable "disk_size" {
}

variable "network" {
}

variable "subnetwork" {
}

variable "kubernetes_masters_ipv4_cidr" {
  type        = string
  default     = "10.0.82.0/28"
  description = "IP CIDR block for the Kubernetes master nodes. This must be exactly /28 and cannot overlap with any other IP CIDR ranges."
}

variable "pods_rangename" {
}

variable "services_rangename" {
}