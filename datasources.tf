# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.oci_tenancy_ocid}"
}
# Gets the OCID of the OS image to use
#data "oci_core_images" "OLImageOCID" {
  #compartment_id           = "${var.compartment_ocid}"
  #operating_system         = "${var.InstanceOS}"
  #operating_system_version = "${var.InstanceOSVersion}"
#}

# Gets a list of vNIC attachments on the demo-instance host
#data "oci_core_vnic_attachments" "InstanceVnics" {
  #compartment_id      = "${var.compartment_ocid}"
  #availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  #instance_id         = "${oci_core_instance.MySql.id}"
#}

# Gets the OCID of the first (default) vNIC on the demo-instance host
#data "oci_core_vnic" "InstanceVnic" {
  #vnic_id = "${lookup(data.oci_core_vnic_attachments.InstanceVnics.vnic_attachments[0],"vnic_id")}"
#}