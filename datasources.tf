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

data "oci_identity_compartments" "security" {
  for_each = var.node_pool
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
    values = [each.value["security_cmp"]]
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

data "oci_core_subnets" "wrkr_subnet" {
  for_each = var.node_pool
  #Required
  compartment_id = local.network_cmp_id

  #Optional
  display_name = each.value["subnet"]
}


# This data source provides the list of Secrets in Oracle Cloud Infrastructure Vault service.
data "oci_vault_secrets" "secret" {
  for_each = var.node_pool
  #Required
  compartment_id = data.oci_identity_compartments.security[each.key].compartments[0].id

  #Optional
  name = each.value["secret"]
}

# This data source provides details about a specific Secretbundle resource in Oracle Cloud Infrastructure Secrets service.
data "oci_secrets_secretbundle" "bundle" {
  for_each = var.node_pool
  #required
  secret_id = data.oci_vault_secrets.secret[each.key].secrets[0].id
}