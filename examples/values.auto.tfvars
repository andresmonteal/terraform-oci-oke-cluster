tenancy_ocid = "tenant-id"

oke_clusters = {
  "oke-cluster-test" = {
    oke_cmp            = "TEST_QA"
    network_cmp        = "NETWORKING"
    api_subnet_name    = "TEST-QA-API-SUBPRI01"
    lb_subnet_name     = "TEST-QA-LB-SUBPRI01"
    kubernetes_version = "v1.27.2"
    defined_tags       = { "application.project" = "test", "application.environment" = "np" }
    node_pool = {
      "oke-nodepool-test" = {
        shape             = "VM.Standard.E4.Flex"
        security_cmp      = "SECURITY"
        secret            = "test"
        memory            = 103
        ocpu              = 54
        subnet            = "TEST-QA-WORKER-SUBPRI01"
        placement_configs = 3
        size              = 3
        image_id          = "ocid1.image.oc1.iad.aaaaaaaa4fuhe5ea45uwesyx262mqyhlcz5ptce5kr5bmqko7pw7wl57s2pa"
      }
    }
  }
}