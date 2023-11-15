resource "oci_core_instance" "lb-01" {
  compartment_id      = var.compartment_id
  display_name        = "lb-01"
  availability_domain = var.instance_availability_domain

  shape = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_cpus
  }

  source_details {
    source_type = var.instance_source_type
    source_id   = var.instance_source_id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.drumetii_subnet.id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

}

resource "oci_core_instance" "app-01" {
  compartment_id      = var.compartment_id
  display_name        = "app-01"
  availability_domain = var.instance_availability_domain

  shape = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_cpus
  }

  source_details {
    source_type = var.instance_source_type
    source_id   = var.instance_source_id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.drumetii_subnet.id
    #assign_public_ip = false
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

}

resource "oci_core_instance" "app-02" {
  compartment_id      = var.compartment_id
  display_name        = "app-02"
  availability_domain = var.instance_availability_domain

  shape = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_cpus
  }

  source_details {
    source_type = var.instance_source_type
    source_id   = var.instance_source_id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.drumetii_subnet.id
    #assign_public_ip = false
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

}

resource "oci_core_instance" "mon-01" {
  compartment_id      = var.compartment_id
  display_name        = "mon-01"
  availability_domain = var.instance_availability_domain

  shape = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_cpus
  }

  source_details {
    source_type = var.instance_source_type
    source_id   = var.instance_source_id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.drumetii_subnet.id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }
}


resource "null_resource" "update_ansible_inventory" {
  # triggers = {
  #   lb_01_ip  = oci_core_instance.lb-01.public_ip
  #   app_01_ip = oci_core_instance.app-01.public_ip
  #   app_02_ip = oci_core_instance.app-02.public_ip
  #   mon_01_ip = oci_core_instance.mon-01.public_ip
  # }

  provisioner "local-exec" {
    command = <<EOT
      echo "[loadbalancers]" > ${var.hosts_file_path}
      echo "lb_01    ansible_host=${oci_core_instance.lb-01.public_ip}    private_ip=${oci_core_instance.lb-01.private_ip}" >> ${var.hosts_file_path}
      echo "" >> ${var.hosts_file_path}
      echo "[webapp]" >> ${var.hosts_file_path}
      echo "app_01    ansible_host=${oci_core_instance.app-01.public_ip}    private_ip=${oci_core_instance.app-01.private_ip}" >> ${var.hosts_file_path}
      echo "app_02    ansible_host=${oci_core_instance.app-02.public_ip}    private_ip=${oci_core_instance.app-02.private_ip}" >> ${var.hosts_file_path}
      echo "" >> ${var.hosts_file_path}
      echo "[monitoring]" >> ${var.hosts_file_path}
      echo "mon_01    ansible_host=${oci_core_instance.mon-01.public_ip}    private_ip=${oci_core_instance.mon-01.private_ip}" >> ${var.hosts_file_path}
      echo "" >> ${var.hosts_file_path}
      echo "[all_hosts]" >> ${var.hosts_file_path}
      echo "lb_01    ansible_host=${oci_core_instance.lb-01.public_ip}    private_ip=${oci_core_instance.lb-01.private_ip}" >> ${var.hosts_file_path}
      echo "app_01    ansible_host=${oci_core_instance.app-01.public_ip}    private_ip=${oci_core_instance.app-01.private_ip}" >> ${var.hosts_file_path}
      echo "app_02    ansible_host=${oci_core_instance.app-02.public_ip}    private_ip=${oci_core_instance.app-02.private_ip}" >> ${var.hosts_file_path}
      echo "mon_01    ansible_host=${oci_core_instance.mon-01.public_ip}    private_ip=${oci_core_instance.mon-01.private_ip}" >> ${var.hosts_file_path}
    EOT
  }
}