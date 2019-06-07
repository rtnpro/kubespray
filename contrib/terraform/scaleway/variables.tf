variable "cluster_name" {
  default = "kubespray"
}

variable "region" {
  default = "ams1"
}

variable "os_image" {
  default = "CentOS 7.6"
}

variable "public_key_path" {
  description = "The path of the ssh pub key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "type_k8s_masters" {
  default = "START1-S"
}

variable "type_k8s_masters_no_etcd" {
  default = "START1-S"
}

variable "type_k8s_masters_calico_rr_no_etcd" {
  default = "START1-S"
}

variable "type_etcd" {
  default = "START1-XS"
}

variable "type_k8s_nodes" {
  default = "START1-S"
}

variable "number_of_k8s_masters" {
  default = 2
}

variable "number_of_k8s_masters_no_etcd" {
  default = 0
}

variable "number_of_k8s_masters_calico_rr_no_etcd" {
  default = 0
}

variable "number_of_etcd" {
  default = 1
}

variable "number_of_k8s_nodes" {
  default = 1
}
