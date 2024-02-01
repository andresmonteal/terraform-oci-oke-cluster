# This resource provides the Cluster resource in Oracle Cloud Infrastructure Container Engine service.
resource "oci_containerengine_cluster" "main" {
  #Required
  compartment_id     = local.oke_cmp_id
  kubernetes_version = var.cluster_kubernetes_version
  name               = var.cluster_name
  vcn_id             = local.api_vcn_id

  defined_tags  = var.defined_tags
  freeform_tags = local.merged_freeform_tags

  #Optional
  dynamic "cluster_pod_network_options" {
    for_each = var.pod_network_options == null ? [] : [0]
    #Required
    content {
      cni_type = var.pod_network_options
    }
  }

  #Optional
  endpoint_config {

    #Optional
    subnet_id = local.api_subnet_id
  }

  options {

    #Optional
    add_ons {

      #Optional
      is_kubernetes_dashboard_enabled = var.is_kubernetes_dashboard_enabled
      is_tiller_enabled               = var.is_tiller_enabled
    }
    kubernetes_network_config {

      #Optional
      pods_cidr     = var.network_config_pods_cidr
      services_cidr = var.network_config_services_cidr
    }

    service_lb_subnet_ids = [local.lb_subnet_id]
  }
}