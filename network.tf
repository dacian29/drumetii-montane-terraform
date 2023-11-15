resource "oci_core_vcn" "drumetii_vcn" {
  compartment_id = var.compartment_id
  display_name   = "Drumetii VCN"
  cidr_blocks    = [var.cidr_blocks]
}

resource "oci_core_subnet" "drumetii_subnet" {
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.drumetii_vcn.id
  cidr_block        = var.cidr_blocks
  display_name      = "Drumetii Subnet"
  dhcp_options_id   = oci_core_vcn.drumetii_vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.drumetii_RT.id
  security_list_ids = [oci_core_security_list.default_SL.id]
  #prohibit_public_ip_on_vnic = false
  #dns_label                  = "drumetii"
}

resource "oci_core_internet_gateway" "drumetii_IG" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.drumetii_vcn.id
  display_name   = "Drumetii Gateway"
}

resource "oci_core_route_table" "drumetii_RT" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.drumetii_vcn.id
  display_name   = "Drumetii Route Table"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.drumetii_IG.id
  }
}

resource "oci_core_security_list" "default_SL" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.drumetii_vcn.id
  display_name   = "Drumetii Security List"

  ingress_security_rules {
    protocol = "all"
    source   = var.cidr_blocks
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "${chomp(data.http.my_ip.response_body)}/32"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "${chomp(data.http.my_ip.response_body)}/32"
    tcp_options {
      min = 1
      max = 65535
    }
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "${chomp(data.http.my_ip.response_body)}/32"
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "${chomp(data.http.my_ip.response_body)}/32"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "${chomp(data.http.my_ip.response_body)}/32"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}