data "oci_identity_compartments" "security_cmp" {
  for_each = var.node_pool
  #Required
  compartment_id = var.tenancy_ocid

  #Optional
  name = each.value["security_cmp"]
}

# This data source provides the list of Secrets in Oracle Cloud Infrastructure Vault service.
data "oci_vault_secrets" "secret" {
  for_each = var.node_pool
  #Required
  compartment_id = data.oci_identity_compartments.security_cmp[each.key].compartments[0].id

  #Optional
  name = each.value["secret"]
}

# This data source provides details about a specific Secretbundle resource in Oracle Cloud Infrastructure Secrets service.
data "oci_secrets_secretbundle" "bundle" {
  for_each = var.node_pool
  #required
  secret_id = data.oci_vault_secrets.secret[each.key].secrets[0].id
}

data "oci_identity_compartments" "network_cmp" {
  for_each = var.node_pool
  #Required
  compartment_id = var.tenancy_ocid

  #Optional
  name = each.value["network_cmp"]
}

data "oci_core_subnets" "subnets" {
  for_each = var.node_pool
  #Required
  compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id

  #Optional
  display_name = each.value["subnet"]
}


data "oci_identity_compartments" "network_cmp_cluster" {
  for_each = var.node_pool
  #Required
  compartment_id = var.tenancy_ocid

  #Optional
  name = var.network_cmp
}

data "oci_core_subnets" "subnet_cluster" {
  for_each = var.node_pool
  #Required
  compartment_id = data.oci_identity_compartments.network_cmp_cluster.compartments[0].id

  #Optional
  display_name = var.subnet
}