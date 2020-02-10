##############################################################################
# This file creates the VPC, Zones, subnets and public gateway for the VPC
# a separate file sets up the load balancers, listeners, pools and members
##############################################################################


##############################################################################
# Create a VPC
##############################################################################

resource ibm_is_vpc vpc {
  name           = "${var.unique_id}-vpc"
  resource_group = "${var.resource_group_id}"
  classic_access = "${var.classic_access}"
}

##############################################################################


##############################################################################
resource ibm_is_public_gateway multi_tier_gateway {

  count = "3"
  name  = "${var.unique_id}-gateway-${count.index + 1}"
  vpc   = "${ibm_is_vpc.vpc.id}"
  zone  = "${var.ibm_region}-${count.index + 1}"

}

##############################################################################
# Tier 1
##############################################################################

module tier_1_subnets {
  
  source           = "./module_vpc_tier"                                # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                                # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-1"                          # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"           # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_1_cidr_blocks}"                        # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                             # ID of VPC for subnet tier
  public_gateways  = "${ibm_is_public_gateway.multi_tier_gateway.*.id}" # List of public gateway IDs
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################


##############################################################################
# Tier 2
##############################################################################

module tier_2_subnets {

  source           = "./module_vpc_tier"                                 # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                                 # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-2"                           # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"            # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_2_cidr_blocks}"                         # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                              # ID of VPC for subnet tier
  public_gateways  = "${ibm_is_public_gateway.multi_tier_gateway.*.id}"  # List of public gateway IDs
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################


##############################################################################
# Tier 3
##############################################################################

module tier_3_subnet_ids {

  source           = "./module_vpc_tier"                                # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                                # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-3"                          # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"           # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_3_cidr_blocks}"                        # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                             # ID of VPC for subnet tier
  public_gateways  = "${ibm_is_public_gateway.multi_tier_gateway.*.id}" # List of public gateway IDs
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################