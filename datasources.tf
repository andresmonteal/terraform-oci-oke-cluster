data "oci_identity_compartments" "oke" {
  count = var.tenancy_ocid == null ? 0 : 1
  #Required
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  compartment_id_in_subtree = true

  #Optional
  filter {
    name   = "state"
    values = ["ACTIVE"]
  }

  filter {
    name   = "name"
    values = [var.oke_cmp]
  }
}

data "oci_identity_compartments" "network" {
  count = var.network_cmp == null ? 0 : 1
  #Required
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  compartment_id_in_subtree = true

  #Optional
  filter {
    name   = "state"
    values = ["ACTIVE"]
  }

  filter {
    name   = "name"
    values = [var.network_cmp]
  }
}

data "oci_core_subnets" "api_subnet" {
  #Required
  compartment_id = local.network_cmp_id

  #Optional
  display_name = var.api_subnet_name
}

data "oci_core_subnets" "lb_subnet" {
  #Required
  compartment_id = local.network_cmp_id

  #Optional
  display_name = var.lb_subnet_name
}