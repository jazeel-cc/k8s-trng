variable "nodepool_name" {
  description = "The name of the node pool"
}

variable "cluster_name" {
  description = "The name of the GKE cluster to add this node pool to"
}

variable "initial_node_count" {
  description = "The initial node count for the pool, per availability zone. Changing this will force recreation of the resource."
  default     = "1"
}

variable "kubernetes_version" {
  description = "The kubernetes version for the nodes in the pool. This should match the Kubernetes version of the GKE cluster."
  default = "1.22.10-gke.600"
}

variable "image_type" {
  description = "The OS image to be used for the nodes."
  default     = "COS"
}

variable "machine_type" {
  description = "The machine type of nodes in the pool."
}

variable "disk_size_in_gb" {
  description = "Disk size, in GB, for the nodes in the pool."
  default     = "100"
}

variable "node_tags" {
  type        = list
  description = "List of strings for tags on node pool VMs. These are generally used for firewall rules."
  default     = []
}

variable "node_labels" {
  description = "Key Value Pairs of Labels to add to the nodes in the pool"
  type        = map
  default     = {}
}

variable "disk_type" {
  description = "Type of the disk attached to each node"
  default     = "pd-standard"
}

variable "additional_oauth_scopes" {
  type        = list
  description = "List of strings for additional oauth scope in a node config"
  default     = []
}

variable "auto_repair" {
  description = "Whether the nodes will be automatically repaired"
  default     = true
}

variable "auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded"
  default     = true
}

variable "preemptible_nodes" {
  description = "Whether to use preemptible nodes"
  default     = false
}

variable "spot_nodes"{
  description = "Whether to use spot nodes"
  default     = false
}

variable "enable_secure_boot" {
  type        = bool
  description = "If shielded nodes is enabled at the cluster level, you can optionally set this to enable secure boot on shielded nodes."
  default     = false
}

variable "taint" {
  description = "Key value pairs of taints to apply on nodes in the pool"
  type        = map
  default     = null
}