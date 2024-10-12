#
##
#

locals {
  # Iterate and loop in the the content for the policies
  service_control_policies = [
    for x in var.service_control_policies : {
      name        = x.name
      description = x.description
      content     = file("${path.module}/{x.filename}")
      target      = x.target
    }
  ]

  # Iterate and loop in the the content for the policies for backup 
  backup_policies = [
    for x in var.backup_policies : {
      name        = x.name
      description = x.description
      content     = file("${path.module}/{x.filename}")
      target      = x.target
    }
  ]

  # Iterate and loop in the the content for the policies for tagging_policies 
  tagging_policies = [
    for x in var.tagging_policies : {
      name        = x.name
      description = x.description
      content     = file("${path.module}/{x.filename}")
      target      = x.target
    }
  ]
}

## Provision the organization, policies and structure
module "organization" {
  source = "../.."

  backup_policies          = local.backup_policies
  enable_delegation        = var.enable_delegation
  service_control_policies = local.service_control_policies
  tagging_policies         = local.tagging_policies
  tags                     = var.tags
}
