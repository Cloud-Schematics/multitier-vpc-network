##############################################################################
# Account Variables
##############################################################################

variable ibm_region {
    description = "Region for resources to be created"
}

variable unique_id {
    description = "Unique ID for subnets created"
}

##############################################################################

##############################################################################
# VPC Variables
##############################################################################

variable acl_id {
    description = "ID of ACL for subnets to use"
}


variable vpc_id {
    description = "ID of VPC where subnet needs to be created"
}

##############################################################################


##############################################################################
# Network variables
##############################################################################

variable cidr_blocks {
    description = "CIDR blocks for subnets to be created"
    default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]  
}

##############################################################################


##############################################################################
# Subnet variables
##############################################################################

variable subnets_per_zone {
    description = "Number of subnets per zone"
    default     = 1
}

variable zones {
    description = "Number of zones to deploy subnets in"
    default     = 3
}

variable public_gateways {
    description = "List of public gateway ids"
    default     = []
}


##############################################################################
