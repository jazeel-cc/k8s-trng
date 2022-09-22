data "google_project" "project" {}

resource "google_container_cluster" "cluster" {
  name                  = var.cluster_name
  min_master_version    = var.kubernetes_version
  network               = var.network_name
  subnetwork            = var.subnetwork_name
  monitoring_service    = var.monitoring_service
  logging_service       = var.logging_service
  enable_shielded_nodes = var.enable_shielded_nodes
  
  #disabled autoscaling by default
  vertical_pod_autoscaling {
    enabled = var.vpa_enabled
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }

  # This is to apply to the default node pool, which gets created then deleted, as you cant create a cluster without nodepool.
  # Upon deletion, then you can create your own nodepools to attach to the cluster using the nodepools module.
  initial_node_count       = 1
  remove_default_node_pool = true

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  ip_allocation_policy {}
  

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled = false
  }

  default_snat_status {
      disabled = false
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.maintenance_policy_start_time
    }
  }

  # resource_labels = {
  #   name = var.cluster_name
  # }
}