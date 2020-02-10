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

variable generation {
  description = "generation for VPC"
  default     = 1
}

##############################################################################


##############################################################################
# Network variables
##############################################################################

variable classic_access {
  description = "Enable VPC Classic Access. Note: only one VPC per region can have classic access"
  default     = false
}

variable enable_public_gateway {
  description = "Enable public gateways, true or false"
  default     = false
}

variable tier_1_cidr_blocks {
  default = [
    "172.16.1.128/27", 
    "172.16.3.128/27", 
    "172.16.5.128/27"
  ]  
}

variable tier_2_cidr_blocks {
  default = [
    "172.16.4.0/25", 
    "172.16.2.0/25", 
    "172.16.0.0/25"
  ]  
}

variable tier_3_cidr_blocks {
  default = [
    "172.16.1.0/26", 
    "172.16.3.0/26", 
    "172.16.5.0/26"
  ]  
}

variable acl_rules {
  default = [
    {
      name        = "egress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    },
    {
      name        = "ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    }
  ]
}

##############################################################################