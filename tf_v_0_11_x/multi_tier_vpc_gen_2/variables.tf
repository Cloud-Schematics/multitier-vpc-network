##############################################################################
# Account Variables
##############################################################################

variable ibmcloud_apikey {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
}

variable unique_id {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
    default     = "multi-tier"
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    default     = "us-south"
}

variable resource_group {
    description = "Name of resource group to create VPC"
    default     = "default"
}
##############################################################################


##############################################################################
# Network variables
##############################################################################

variable classic_access {
  description = "Enable VPC Classic Access. Note: only one VPC per region can have classic access"
  default     = false
}

variable tier_1_cidr_blocks {
  description = "List of CIDR blocks for tier 1"
  default     = [
    "172.16.1.128/27", 
    "172.16.3.128/27", 
    "172.16.5.128/27"
  ]  
}

variable tier_2_cidr_blocks {
  description = "List of CIDR blocks for tier 2"
  default     = [
    "172.16.4.0/25", 
    "172.16.2.0/25", 
    "172.16.0.0/25"
  ]  
}

variable tier_3_cidr_blocks {
  description = "List of CIDR blocks for tier 3"
  default     = [
    "172.16.1.0/26", 
    "172.16.3.0/26", 
    "172.16.5.0/26"
  ]  
}

variable subnets_per_zone {
    description = "Number of subnets per zone"
    default     = 1
}

variable zones {
    description = "Number of zones to deploy subnets in"
    default     = 3
}

##############################################################################