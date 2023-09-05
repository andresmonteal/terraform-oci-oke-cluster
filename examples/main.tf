module "oke_cluster" {
  source = "../"

  for_each = var.oke_clusters

  # general oci parameters
  tenancy_ocid  = var.tenancy_ocid
  oke_cmp       = each.value["oke_cmp"]
  freeform_tags = lookup(each.value, "freeform_tags", null)
  defined_tags  = lookup(each.value, "defined_tags", null)

  # compute instance parameters
  cluster_kubernetes_version = each.value["kubernetes_version"]
  cluster_name               = each.key

  # networking parameters
  api_subnet_name = each.value["api_subnet_name"]
  lb_subnet_name  = each.value["lb_subnet_name"]
  network_cmp     = each.value["network_cmp"]

  # node pool
  node_pool = lookup(each.value, "node_pool", {})
}