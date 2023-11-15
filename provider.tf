terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      #source  = "hashicorp/oci"
      version = "5.17.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key
  region           = var.region
}