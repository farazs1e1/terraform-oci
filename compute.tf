

resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "ocid1.compartment.oc1..aaaaaaaau3nbpnuhyvxg7qsjcmorpl4abtq23jzyyspeoabhofx5jq3aug5q"
    shape = "VM.Standard.E2.1"
    source_details {
        source_id = "ocid1.image.oc1.iad.aaaaaaaa2zjkrjfmn2qv6mkcupitlf6ittlm7pjap5oi3oppsmtfbgkmxscq"
        source_type = "image"
    }

    # Optional
    display_name = "your-ubuntu-instance-name"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaa3xn4t6imkezojwhk4yklypelmcrun6sdeqzf3iqbfnx6leuwjyba"
    }
    metadata = {
        ssh_authorized_keys = file("/root/tf-compute/mykey.pub")
	user_data	    = "IyEvYmluL2Jhc2gKc3VkbyBzdSByb290CnNlZCAtaSAnMCwvI1Bhc3N3b3JkQXV0aGVudGljYXRpb24geWVzL3MvL1Bhc3N3b3JkQXV0aGVudGljYXRpb24geWVzLycgL2V0Yy9zc2gvc3NoZF9jb25maWcKZWNobyAicm9vdDpUcHNUcHNfMSIgfCBjaHBhc3N3ZApzeXN0ZW1jdGwgcmVzdGFydCBzc2hkCnN1ZG8gYXB0IGluc3RhbGwgYXBhY2hlMiAteQpzdWRvIGVjaG8gInN5c3RlbW1tbSIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1sLwpzdWRvIHN5c3RlbWN0bCByZXN0YXJ0IGFwYWNoZTI="
}
    preserve_boot_volume = false

}
resource "oci_core_volume" "test_block_volume_paravirtualized" {
  availability_domain =  data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaau3nbpnuhyvxg7qsjcmorpl4abtq23jzyyspeoabhofx5jq3aug5q"
  display_name        = "volume_display_name"
  size_in_gbs         = 60
}

resource "oci_core_volume_attachment" "test_block_volume_attach_paravirtualized" {
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.ubuntu_instance.id
  volume_id       = oci_core_volume.test_block_volume_paravirtualized.id
}
