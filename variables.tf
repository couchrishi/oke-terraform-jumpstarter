# Authentication
variable "oci_tenancy_ocid" {}

variable "oci_user_ocid" {}
variable "oci_fingerprint" {}
variable "oci_private_key_path" {}

variable "compartment_ocid" {}
variable "oci_ssh_public_key" {}
variable "oci_ssh_private_key" {}

variable "oci_region" {
  default = "us-ashburn-1"
}

variable "InstanceShape" {
  default = "VM.Standard1.4"
}

variable "DemoShape" {
  default = "VM.Standard1.4"
}
variable "TomcatVMShape" {
  default = "VM.Standard2.1"
}

variable "InstanceOS" {
  default = "Oracle Linux"
}

variable "InstanceOSVersion" {
  default = "7.5"
}

variable "VCN-CIDR" {
  default = "11.0.0.0/16"
}

variable "worker1AD1CIDR" {
  default = "11.0.10.0/24"
}

variable "worker2AD2CIDR" {
  default = "11.0.11.0/24"
}

variable "worker3AD3CIDR" {
  default = "11.0.12.0/24"
}

variable "lb1AD1CIDR" {
  default = "11.0.20.0/24"
}

variable "lb2AD2CIDR" {
  default = "11.0.21.0/24"
}
variable "lbshape" {
  default = "100Mbs"
}




### Added for Block , block.tf , remote-exec.tf

# Choose an Availability Domain
variable "AD" {
  default = "1"
}

variable "2TB" {
  default = "2097152"
}

variable "50GB" {
  default = "51200"
}
