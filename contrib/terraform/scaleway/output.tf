output "k8s_masters" {
  value = "${scaleway_server.k8s_master.*.public_ip}"
}

output "k8s_masters_no_etc" {
  value = "${scaleway_server.k8s_master_no_etcd.*.public_ip}"
}

output "k8s_etcds" {
  value = "${scaleway_server.k8s_etcd.*.public_ip}"
}

output "k8s_nodes" {
  value = "${scaleway_server.k8s_node.*.public_ip}"
}
