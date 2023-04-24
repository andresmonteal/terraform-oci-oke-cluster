module "oci-oke" {
  source = "git::ssh://devops.scmservice.us-ashburn-1.oci.oraclecloud.com/namespaces/id9de6bj2yv6/projects/claro-devops/repositories/terraform-oci-oke-cluster?ref=v0.1.4"

  for_each = var.oke_clusters

  tenancy_ocid               = var.tenancy_ocid
  compartment_id             = data.oci_identity_compartments.cmp_lvl3[each.key].compartments[0].id
  cluster_kubernetes_version = each.value["kubernetes_version"]
  cluster_name               = each.key
  vcn_id                     = data.oci_core_vcns.vcns[each.key].virtual_networks[0].id
  subnet_id                  = data.oci_core_subnets.subnet_cluster[each.key].subnets[0].id

  defined_tags  = lookup(each.value, "defined_tags", {})
  freeform_tags = lookup(each.value, "freeform_tags", {})

  node_pool = lookup(each.value, "node_pool", {})

}