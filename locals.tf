locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-oke-cluster"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
  oke_cmp_id           = try(data.oci_identity_compartments.oke[0].compartments[0].id, var.oke_cmp_id)
  network_cmp_id       = try(data.oci_identity_compartments.network[0].compartments[0].id, var.network_cmp_id)
  api_vcn_id           = data.oci_core_subnets.api_subnet.subnets[0].vcn_id
  api_subnet_id        = data.oci_core_subnets.api_subnet.subnets[0].id
  lb_subnet_id         = data.oci_core_subnets.lb_subnet.subnets[0].id
}