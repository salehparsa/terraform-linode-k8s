output "kubeconfig" {
   value = linode_lke_cluster.assignment-cluster.kubeconfig
}

output "api_endpoints" {
   value = linode_lke_cluster.assignment-cluster.api_endpoints
}

output "status" {
   value = linode_lke_cluster.assignment-cluster.status
}

output "id" {
   value = linode_lke_cluster.assignment-cluster.id
}

output "pool" {
   value = linode_lke_cluster.assignment-cluster.pool
}