resource "oci_core_virtual_network" "k8scluster-vcn" {
  cidr_block     = "${var.VCN-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "k8scluster-vcn"
  dns_label      = "k8sclustervcn"
}

resource "oci_core_internet_gateway" "gateway-0" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "gateway-0"
  vcn_id         = "${oci_core_virtual_network.k8scluster-vcn.id}"
}

resource "oci_core_route_table" "routetable-0" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.k8scluster-vcn.id}"
  display_name   = "routetable-0"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.gateway-0.id}"
  }
}

resource "oci_core_security_list" "workers" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "workers"
  vcn_id         = "${oci_core_virtual_network.k8scluster-vcn.id}"

  egress_security_rules = [{
    protocol    = "All"
    destination = "0.0.0.0/0"
  },
    {
      protocol    = "All"
      destination = "11.0.10.0/24"
      stateless = "True"
    },
    {
      protocol    = "All"
      destination = "11.0.11.0/24"
      stateless = "True"
    },
     {
      protocol    = "All"
      destination = "11.0.12.0/24"
      stateless = "True"
    },
  ]

  ingress_security_rules = [
    {
      tcp_options = {
        "max" = 32767
        "min" = 30000
      }
      protocol = "6"
      source   = "0.0.0.0/0"
    },
    {
      tcp_options = {
        "max" = 22
        "min" = 22
      }
      protocol = "6"
      source   = "0.0.0.0/0"
    },

      {
      tcp_options = {
        "max" = 22
        "min" = 22
      }
      protocol = "6"
      source   = "138.1.0.0/17"
    },

    {
      tcp_options = {
        "max" = 22
        "min" = 22
      }
      protocol = "6"
      source   = "130.35.0.0/16"
    },

    {
      icmp_options = {
        "type" = 3
        "code" = 4
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },

   {
      protocol    = "All"
      source = "11.0.10.0/24"
      stateless = "True"
    },

   {
      protocol    = "All"
      source = "11.0.11.0/24"
      stateless = "True"
    },

     {
      protocol    = "All"
      source = "11.0.12.0/24"
      stateless = "True"
    },
  ]
}

resource "oci_core_security_list" "loadbalancers" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "loadbalancers"
  vcn_id         = "${oci_core_virtual_network.k8scluster-vcn.id}"

  egress_security_rules = [{
      protocol    = "All"
      destination = "0.0.0.0/0"
    },
    ]
  ingress_security_rules = [{
      protocol    = "All"
      source = "0.0.0.0/0"
    },
  ]
}
resource "oci_core_subnet" "workers-1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.worker1AD1CIDR}"
  display_name        = "workers-1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.k8scluster-vcn.id}"
  route_table_id      = "${oci_core_route_table.routetable-0.id}"
  security_list_ids   = ["${oci_core_security_list.workers.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.k8scluster-vcn.default_dhcp_options_id}"
  dns_label           = "worker1AD1CIDR"
}

resource "oci_core_subnet" "workers-2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${var.worker2AD2CIDR}"
  display_name        = "workers-2"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.k8scluster-vcn.id}"
  route_table_id      = "${oci_core_route_table.routetable-0.id}"
  security_list_ids   = ["${oci_core_security_list.workers.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.k8scluster-vcn.default_dhcp_options_id}"
  dns_label           = "worker2AD2CIDR"
}

resource "oci_core_subnet" "workers-3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${var.worker3AD3CIDR}"
  display_name        = "workers-3"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.k8scluster-vcn.id}"
  route_table_id      = "${oci_core_route_table.routetable-0.id}"
  security_list_ids   = ["${oci_core_security_list.workers.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.k8scluster-vcn.default_dhcp_options_id}"
  dns_label           = "worker3AD3CIDR"
}

resource "oci_core_subnet" "loadbalancers-1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.lb1AD1CIDR}"
  display_name        = "loadbalancers-1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.k8scluster-vcn.id}"
  route_table_id      = "${oci_core_route_table.routetable-0.id}"
  security_list_ids   = ["${oci_core_security_list.loadbalancers.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.k8scluster-vcn.default_dhcp_options_id}"
  dns_label           = "lb1AD1CIDR"
}

resource "oci_core_subnet" "loadbalancers-2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${var.lb2AD2CIDR}"
  display_name        = "loadbalancers-2"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.k8scluster-vcn.id}"
  route_table_id      = "${oci_core_route_table.routetable-0.id}"
  security_list_ids   = ["${oci_core_security_list.loadbalancers.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.k8scluster-vcn.default_dhcp_options_id}"
  dns_label           = "lb2AD2CIDR"
}