# Configure the Scaleway Provider
provider "scaleway" {
  version = "~> v1.9.2"
  region = "${var.region}"
}

resource "scaleway_ssh_key" "k8s" {
  count      = "${var.public_key_path != "" ? 1 : 0}"
  key = "${chomp(file(var.public_key_path))}"
}

data "scaleway_image" "os" {
  architecture = "x86_64"
  name         = "${var.os_image}"
}

resource "scaleway_ip" "k8s_master" {
  count = "${var.number_of_k8s_masters}"
}

resource "scaleway_server" "k8s_master" {
  depends_on = ["scaleway_ssh_key.k8s", "scaleway_ip.k8s_master"]

  count            = "${var.number_of_k8s_masters}"
  name             = "${var.cluster_name}-k8s-master-${count.index+1}"
  type             = "${var.type_k8s_masters}"
  image            = "${data.scaleway_image.os.id}"
  public_ip        = "${element(scaleway_ip.k8s_master.*.ip, count.index)}"
  tags             = ["cluster-${var.cluster_name}", "k8s-cluster", "kube-master", "etcd"]
}

resource "scaleway_ip" "k8s_master_no_etcd" {
  count = "${var.number_of_k8s_masters_no_etcd}"
}

resource "scaleway_server" "k8s_master_no_etcd" {
  depends_on = ["scaleway_ssh_key.k8s", "scaleway_ip.k8s_master_no_etcd"]

  count     = "${var.number_of_k8s_masters_no_etcd}"
  name      = "${var.cluster_name}-k8s-master-${count.index+1}"
  type      = "${var.type_k8s_masters_no_etcd}"
  image     = "${data.scaleway_image.os.id}"
  public_ip = "${element(scaleway_ip.k8s_master_no_etcd.*.ip, count.index)}"
  tags      = ["cluster-${var.cluster_name}", "k8s-cluster", "kube-master"]
}
resource "scaleway_ip" "k8s_master_calico_rr_no_etcd" {
  count = "${var.number_of_k8s_masters_calico_rr_no_etcd}"
}

resource "scaleway_server" "k8s_master_no_etcd_calico_rr" {
  depends_on = ["scaleway_ssh_key.k8s", "scaleway_ip.k8s_master_calico_rr_no_etcd"]

  count     = "${var.number_of_k8s_masters_calico_rr_no_etcd}"
  name      = "${var.cluster_name}-k8s-master-${count.index+1}"
  type      = "${var.type_k8s_masters_calico_rr_no_etcd}"
  image     = "${data.scaleway_image.os.id}"
  public_ip = "${element(scaleway_ip.k8s_master_calico_rr_no_etcd.*.ip, count.index)}"
  tags      = ["cluster-${var.cluster_name}", "k8s-cluster", "kube-master", "calico-rr"]
}

resource "scaleway_ip" "k8s_etcd" {
  count = "${var.number_of_etcd}"
}

resource "scaleway_server" "k8s_etcd" {
  depends_on = ["scaleway_ssh_key.k8s", "scaleway_ip.k8s_etcd"]

  count     = "${var.number_of_etcd}"
  name      = "${var.cluster_name}-etcd-${count.index+1}"
  type      = "${var.type_etcd}"
  image     = "${data.scaleway_image.os.id}"
  public_ip = "${element(scaleway_ip.k8s_etcd.*.ip, count.index)}"
  tags      = ["cluster-${var.cluster_name}", "etcd"]
}

resource "scaleway_ip" "k8s_node" {
  count = "${var.number_of_k8s_nodes}"
}

resource "scaleway_server" "k8s_node" {
  depends_on = ["scaleway_ssh_key.k8s", "scaleway_ip.k8s_node"]

  count     = "${var.number_of_k8s_nodes}"
  name      = "${var.cluster_name}-k8s-node-${count.index+1}"
  type      = "${var.type_k8s_nodes}"
  image     = "${data.scaleway_image.os.id}"
  public_ip = "${element(scaleway_ip.k8s_node.*.ip, count.index)}"
  tags      = ["cluster-${var.cluster_name}", "k8s-cluster", "kube-node"]
}
