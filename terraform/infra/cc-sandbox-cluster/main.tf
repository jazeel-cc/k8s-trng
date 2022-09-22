module "puvss_cluster" {
  source                           = "../../modules/cluster"
  cluster_name                     = "cc-jazeel"
  kubernetes_version               = "1.22.12-gke.300"
  network_name                     = "default"
  subnetwork_name                  = "default"
  enable_shielded_nodes            = "true"
  # private cluster options
  enable_private_endpoint          = false
  enable_private_nodes             = false
  #maintenance
  maintenance_policy_start_time    = "06:00"
}