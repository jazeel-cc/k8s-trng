output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.cluster.name
}

output "endpoint" {
  description = "The GKE Cluster Endpoints IP"
  value       = google_container_cluster.cluster.endpoint
}