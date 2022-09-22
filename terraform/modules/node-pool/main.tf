locals {
  base_oauth_scope = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/compute",
  ]
}

resource "google_container_node_pool" "node_pool" {
  name               = var.nodepool_name
  cluster            = var.cluster_name
  version            = var.kubernetes_version
  initial_node_count = var.initial_node_count

  node_config {
    image_type   = var.image_type
    disk_size_gb = var.disk_size_in_gb
    machine_type = var.machine_type
    labels       = var.node_labels
    disk_type    = var.disk_type
    tags         = var.node_tags
    preemptible  = var.preemptible_nodes
    spot         = var.spot_nodes
    shielded_instance_config {
      enable_secure_boot = var.enable_secure_boot
    }

    #to dynamically add a taint to nodes IF they require a taint. for e.g. for the ml-node-pool 
    dynamic "taint" {
      for_each = toset(var.taint == null ? [] : [var.taint])
      content {
        effect = var.taint.effect
        key    = var.taint.key
        value  = var.taint.value
      }
    }
    oauth_scopes = concat(local.base_oauth_scope, var.additional_oauth_scopes)
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }
}