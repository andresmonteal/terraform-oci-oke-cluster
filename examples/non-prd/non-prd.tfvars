oke_clusters = {
  "CLUSTER-NAME" = {
    network_cmp        = "NETWORKING"
    vcn                = "VCN-NAME"
    cmp                = ["LVL1", "LVL2", "LVL3"]
    kubernetes_version = "v1.24.1"
    defined_tags       = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    subnet             = "API-SUBNET-NAME"
    node_pool = {
      "ITSM-HELIX-DEVPOOL1" = {
        shape             = "VM.Standard.E4.Flex"
        security_cmp      = "SECURITY"
        secret            = "ssh-key-pub"
        memory            = 103
        ocpu              = 54
        network_cmp       = "NETWORKING"
        subnet            = "WORKER-SUBNET-NAME"
        placement_configs = 3
        size              = 3
        image_id          = "ocid1.image.oc1.iad.aaaaaaaa4fuhe5ea45uwesyx262mqyhlcz5ptce5kr5bmqko7pw7wl57s2pa"
      }
    }
  },
  "CLUSTER-NAME-2" = {
    network_cmp        = "NETWORKING"
    vcn                = "VCN-NAME"
    cmp                = ["LVL1", "LVL2", "LVL3"]
    kubernetes_version = "v1.24.1"
    defined_tags       = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    subnet             = "SUBNET-NAME"
    node_pool = {
      "ITSM-HELIX-DEVPOOL1" = {
        shape             = "VM.Standard.E4.Flex"
        security_cmp      = "SECURITY"
        secret            = "ssh-key-pub"
        memory            = 100
        ocpu              = 52
        network_cmp       = "NETWORKING"
        subnet            = "WORKER-SUBNET-NAME"
        placement_configs = 3
        size              = 5
        image_id          = "ocid1.image.oc1.iad.aaaaaaaa4fuhe5ea45uwesyx262mqyhlcz5ptce5kr5bmqko7pw7wl57s2pa"
      }
    }
  }
}