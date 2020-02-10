##############################################################################
# Create a VPC in the resource group
#
# Uncomment like 10 for classic access
##############################################################################

resource ibm_is_vpc vpc {
  name           = "${var.unique_id}-vpc"
  resource_group = "${data.ibm_resource_group.resource_group.id}"
  classic_access = "${var.classic_access}"
}

##############################################################################


##############################################################################
# Create an ACL for inbound/outbound used by all subnets in VPC
##############################################################################

resource ibm_is_network_acl multizone_acl {
  name  = "${var.unique_id}-multizone-acl"
  vpc   = "${ibm_is_vpc.vpc.id}"
  rules = [
    {
      name   = "egress"
      action = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    },
    {
      name   = "ingress"
      action = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    }
  ]
}

##############################################################################


##############################################################################
# Creates tier subnets
#
# Tiers also accept these arguments:
# > subnets_per_zone 
#   - Subnets per zone, defaults to 1
# > zones
#   - Number of zones, defaults to 3
##############################################################################


##############################################################################
# Tier 1
##############################################################################

module tier_1_subnets {
  
  source           = "./module_vpc_tier"                       # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                       # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-1"                 # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"  # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_1_cidr_blocks}"               # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                    # ID of VPC for subnet tier
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################


##############################################################################
# Tier 2
##############################################################################

module tier_2_subnets {

  source           = "./module_vpc_tier"                       # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                       # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-2"                 # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"  # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_2_cidr_blocks}"               # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                    # ID of VPC for subnet tier
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################


##############################################################################
# Tier 3
##############################################################################

module tier_3_subnets {

  source           = "./module_vpc_tier"                       # Module source folder

  # Account Variables
  ibm_region       = "${var.ibm_region}"                       # IBM Cloud Region
  unique_id        = "${var.unique_id}-tier-3"                 # Unique ID for subnet tier

  # VPC Variables
  acl_id           = "${ibm_is_network_acl.multizone_acl.id}"  # ID of ACL for the subnet tier
  cidr_blocks      = "${var.tier_3_cidr_blocks}"               # List of CIDR blocks
  vpc_id           = "${ibm_is_vpc.vpc.id}"                    # ID of VPC for subnet tier
  zones            = "${var.zones}"
  subnets_per_zone = "${var.subnets_per_zone}"

}

##############################################################################