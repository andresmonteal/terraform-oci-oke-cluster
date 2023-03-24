variable "tenancy_ocid" {
  description = "(Required) The OCID of the root compartment."
  type        = string
}

variable "compartment_id" {
  description = "(Required) The OCID of the compartment in which to create the cluster."
  type        = string
}

variable "cluster_kubernetes_version" {
  description = "(Required) (Updatable) The version of Kubernetes to install into the cluster masters."
  type        = string
}

variable "cluster_name" {
  description = "(Required) (Updatable) The name of the cluster. Avoid entering confidential information."
  type        = string
}

variable "vcn_id" {
  description = "(Required) The OCID of the virtual cloud network (VCN) in which to create the cluster."
  type        = string
}

variable "subnet" {
  description = "(Required) The OCID of the subnet which the API would use."
  type        = string
}

# optional
variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace."
  type        = map(string)
  default     = {}
}

variable "pod_network_options" {
  description = "(Optional) Available CNIs and network options for existing and new node pools of the cluster."
  type        = string
  default     = null
}

variable "is_kubernetes_dashboard_enabled" {
  description = "(Optional) Whether or not to enable the Kubernetes Dashboard add-on."
  type        = bool
  default     = false
}

variable "is_tiller_enabled" {
  description = "(Optional) Whether or not to enable the Tiller add-on."
  type        = bool
  default     = false
}

variable "network_config_pods_cidr" {
  description = "(Optional) The CIDR block for Kubernetes pods. Optional, defaults to 10.244.0.0/16."
  type        = string
  default     = "10.244.0.0/16"
}

variable "network_config_services_cidr" {
  description = "(Optional) The CIDR block for Kubernetes services. Optional, defaults to 10.96.0.0/16."
  type        = string
  default     = "10.96.0.0/16"
}

variable "lb_subnet_ids" {
  description = "(Optional) (Updatable) Configuration to be applied to load balancers created by Kubernetes services"
  type        = list(string)
  default     = []
}

variable "node_pool" {
  description = "(Optional) provides the Node Pool resource in Oracle Cloud Infrastructure Container Engine service."
  type        = map(any)
  default     = {}
}