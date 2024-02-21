output "cluster_id" {
  description = "Kapsule Cluster ID."
  value       = scaleway_k8s_cluster.cluster.id
}

output "cluster_name" {
  description = "Kapsule Cluster name."
  value       = scaleway_k8s_cluster.cluster.name
}

output "cluster_version" {
  description = "Kapsule Cluster version."
  value       = scaleway_k8s_cluster.cluster.version
}

output "cluster_wildcard_dns" {
  description = "The DNS wildcard that points to all ready nodes."
  value       = scaleway_k8s_cluster.cluster.wildcard_dns
}

output "cluster_status" {
  description = "Kapsule Cluster status of the Kubernetes cluster."
  value       = scaleway_k8s_cluster.cluster.status
}

output "cluster_upgrade_available" {
  description = "Set to `true` if a newer Kubernetes version is available."
  value       = scaleway_k8s_cluster.cluster.upgrade_available
}

output "control_plane_endpoint" {
  description = "Kapsule Cluster API endpoint."
  value       = scaleway_k8s_cluster.cluster.apiserver_url
}

output "control_plane_host" {
  description = "Kapsule Cluster URL of the Kubernetes API server."
  value       = scaleway_k8s_cluster.cluster.kubeconfig[0].host
  sensitive   = true
}

output "control_plane_ca" {
  description = "Kapsule Cluster CA certificate of the Kubernetes API server."
  value       = scaleway_k8s_cluster.cluster.kubeconfig[0].cluster_ca_certificate
  sensitive   = true
}

output "control_plane_token" {
  description = "Kapsule Cluster token to connect to the Kubernetes API server."
  value       = scaleway_k8s_cluster.cluster.kubeconfig[0].token
  sensitive   = true
}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${scaleway_k8s_cluster.cluster.kubeconfig[0].host}
    certificate-authority-data: ${scaleway_k8s_cluster.cluster.kubeconfig[0].cluster_ca_certificate}
  name: ${var.customer}-kapsule-${var.cluster_name}
contexts:
- context:
    cluster: ${var.customer}-kapsule-${var.cluster_name}
    user: ${var.customer}-scw-${var.cluster_name}
  name: ${var.customer}-${var.cluster_name}
current-context: ${var.customer}-${var.cluster_name}
kind: Config
preferences: {}
users:
- name: ${var.customer}-scw-${var.cluster_name}
  user:
    token: ${scaleway_k8s_cluster.cluster.kubeconfig[0].token}
KUBECONFIG
}

output "kubeconfig" {
  description = "Kubernetes config to connect to the Kapsule Cluster."
  value       = local.kubeconfig
  sensitive   = true
}

output "scaleway_vpc_id" {
  value = scaleway_vpc.vpc.id
}

output "scaleway_vpc_private_network_id" {
  value = scaleway_vpc_private_network.priv.id
}

output "nat_gw_ip" {
  value = scaleway_vpc_public_gateway_ip.pub.address
}

output "private_network_cidr" {
  value = var.private_network_cidr
}
