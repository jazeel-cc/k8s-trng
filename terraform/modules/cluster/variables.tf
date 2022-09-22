variable "cluster_name" {
  description = "The name of the GKE cluster"
}

variable "network_name" {
  description = "The name of an existing google_compute_network resource to which the cluster will be connected."
}

variable "subnetwork_name" {
  description = "The name of an existing google_compute_subnetwork resource where cluster compute instances are launched."
}

variable "kubernetes_version" {
  description = "The minimum version of master nodes. This can be changed to upgrade the cluster - remember to upgrade the Kubernetes version for node pools (managed separately)."
  default = "1.22.10-gke.600"
}

variable "maintenance_policy_start_time" {
  description = "The time (in GMT) when the cluster maintenance window will start."
  default     = "06:00"
}

variable "enable_private_endpoint" {
  description = "A boolean to enable private (non public) kube-api endpoints"
  default     = false
}

variable "enable_private_nodes" {
  description = "A boolean to enable private (non public) nodes"
  default     = false
}

variable "master_ipv4_cidr_block" {
  description = "The /28 range for the master instances. Must be set if enable_private_nodes or enable_private_endpoint is true"
  default     = null
}

variable "monitoring_service" {
  description = "The monitoring service to write metrics to"
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "logging_service" {
  description = "The logging service to write logs to"
  default     = "logging.googleapis.com/kubernetes"
}

variable "vpa_enabled" {
  description = "A boolean to enable VPA for the cluster"
  default     = false
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "A boolean to enable cluster-wide shielded nodes"
  default     = false
}