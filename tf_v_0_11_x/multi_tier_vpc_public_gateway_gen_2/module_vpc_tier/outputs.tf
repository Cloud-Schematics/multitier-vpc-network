##############################################################################
# Outputs
##############################################################################

output subnet_ids {
  description = "IDs of subnets created for this tier"
  value       = "${ibm_is_subnet.subnet.*.id}"
}  

##############################################################################