# Source from https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains

data "oci_identity_availability_domains" "ads" {
	#compartment_id = "ocid1.tenancy.oc1..aaaaaaaahkky2gtu44xyqnr5eevk4pgw47py7l6f2aq3cji4gadrmh7z3uuq"
	compartment_id = "ocid1.compartment.oc1..aaaaaaaau3nbpnuhyvxg7qsjcmorpl4abtq23jzyyspeoabhofx5jq3aug5q"
}

