output "id" {
  description = "The OCID of the cluster."
  value       = oci_containerengine_cluster.main.id
}

output "compartment_id" {
  description = "The OCID of the compartment in which the cluster exists."
  value       = oci_containerengine_cluster.main.compartment_id
}

output "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace."
  value       = oci_containerengine_cluster.main.defined_tags
}

output "kubernetes_version" {
  description = "The version of Kubernetes running on the cluster masters."
  value       = oci_containerengine_cluster.main.kubernetes_version
}
