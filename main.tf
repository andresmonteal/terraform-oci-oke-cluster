locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-oke-cluster"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
}

# This resource provides the Cluster resource in Oracle Cloud Infrastructure Container Engine service.
resource "oci_containerengine_cluster" "main" {
  #Required
  compartment_id     = var.compartment_id
  kubernetes_version = var.cluster_kubernetes_version
  name               = var.cluster_name
  vcn_id             = var.vcn_id

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
    subnet_id = data.oci_core_subnets.subnet_cluster.subnets[0].id
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

    service_lb_subnet_ids = var.lb_subnet_ids
  }
}

module "node_pool" {
  source = "git@github.com:andresmonteal/terraform-oci-oke-node-pool.git?ref=v0.1.0"

  for_each = var.node_pool

  cluster_id      = oci_containerengine_cluster.main.id
  tenancy_ocid    = var.tenancy_ocid
  compartment_id  = var.compartment_id
  node_pool_name  = each.key
  node_pool_shape = each.value["shape"]

  defined_tags                 = var.defined_tags
  node_pool_kubernetes_version = var.cluster_kubernetes_version
  ssh_public_key               = base64decode(data.oci_secrets_secretbundle.bundle[each.key].secret_bundle_content.0.content)

  shape_memory = each.value["memory"]
  shape_ocpus  = each.value["ocpu"]

  subnet_id = data.oci_core_subnets.subnets[each.key].subnets[0].id

  placement_configs = each.value["placement_configs"]
  node_pool_size    = each.value["size"]

  node_pool_image_id = each.value["image_id"]
}