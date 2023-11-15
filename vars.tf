# ------Provider Variables-----------------------------------------------------------------------------
variable "ssh_private_key" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
# ------Network Variables--------------------------------------------------------------------------------
variable "compartment_id" {}
variable "region" {}
variable "cidr_blocks" {}
variable "ssh_public_key" {}
data "http" "my_ip" {
  url = "http://ipinfo.io/ip"
}
# ------Instance Variables--------------------------------------------------------------------------------
variable "instance_availability_domain" {}
variable "instance_shape" {}
variable "instance_source_type" {}
variable "instance_source_id" {}
variable "instance_memory" {}
variable "instance_cpus" {}
# -------Ansible hosts file--------------------------------------------------------------------------------
variable "hosts_file_path" {}

