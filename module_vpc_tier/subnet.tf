##############################################################################
# Prefixes and subnets
#
# Creates a number of address prefixes per zone equal to the subnets per 
# zone times the number of zones
##############################################################################

resource ibm_is_vpc_address_prefix subnet_prefix {
  count = "${var.subnets_per_zone * var.zones}"

  name  = "${var.unique_id}-prefix-zone-${(count.index % var.zones) + 1}" # ex. ex-tf-prefix-zone-1
  zone  = "${var.ibm_region}-${(count.index % var.zones) + 1}"            # will create a zone based on the count mod the number of zones 
  vpc   = "${var.vpc_id}"                                                 # VPC ID
  cidr  = "${element(var.cidr_blocks, count.index)}"                      # CIDR Block from array
}

##############################################################################


##############################################################################
# Create Subnets
#
# Creates a number of subnets per zone equal to the subnets per zone
# time the number of zones
##############################################################################

resource ibm_is_subnet subnet {
  count           = "${var.subnets_per_zone * var.zones}"

  name            = "${var.unique_id}-subnet-${count.index + 1}"                                            # ex. ex-tf-subnet-1
  vpc             = "${var.vpc_id}"                                                                         # VPC ID
  zone            = "${var.ibm_region}-${(count.index % var.zones) + 1}"                                    # will create a zone based on the count mod the number of zones
  ipv4_cidr_block = "${element(ibm_is_vpc_address_prefix.subnet_prefix.*.cidr, count.index)}"               # Gets the CIDR of the prefi
  network_acl     = "${var.acl_id != "" ? var.acl_id : null}"                                                     # ID of ACL for this subnet tier
  public_gateway  = "${length(var.public_gateways) > 0 ? element(var.public_gateways, count.index) : null}"
}

##############################################################################