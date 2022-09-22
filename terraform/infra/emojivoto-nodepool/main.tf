module "emojivoto_pool" {
  source                           = "../../modules/node-pool"
  nodepool_name                    = "emojivoto"
  cluster_name                     = data.google_container_cluster.cluster.name #refer to providers.tf
  kubernetes_version               = "1.22.12-gke.300"
  initial_node_count               = "1"
  disk_size_in_gb                  = "10"
  image_type                       = "COS"
  machine_type                     = "e2-standard-4"
  disk_type                        = "pd-standard"
  preemptible_nodes                = false
  spot_nodes                       = true
  enable_secure_boot               = false
  auto_upgrade                     = true
  auto_repair                      = true

  node_labels = {
    app = "emojivoto"
  }

  taint = {
    key    = "app"
    value  = "emojivoto"
    effect = "NO_SCHEDULE"
  }
}
