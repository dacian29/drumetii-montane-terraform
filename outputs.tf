output "lb_01_ip" {
  value = oci_core_instance.lb-01.public_ip
}

output "app_01_ip" {
  value = oci_core_instance.app-01.public_ip
}

output "app_02_ip" {
  value = oci_core_instance.app-02.public_ip
}

output "mon_01_ip" {
  value = oci_core_instance.mon-01.public_ip
}