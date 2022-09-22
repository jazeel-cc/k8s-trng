data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  name     = "cc-jazeel"
}

#required block to authenticate terraform with the GKE cluster
provider "kubernetes" {
  host  = "https://${data.google_container_cluster.puvss_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.puvss_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "google" {
  project = "devops-sandbox-20200519"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-a"
}