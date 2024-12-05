#
##
#

locals {
  # Iterate and loop in the the content for the policies
  service_control_policies = {
    for k, x in var.service_control_policies : k => {
      description = x.description
      content     = file(format("${path.module}/%s", x.filename))
      key         = x.key
      target_id   = x.target_id
    }
  }

  # Iterate and loop in the the content for the policies for backup
  backup_policies = {
    for k, x in var.backup_policies : k => {
      description = x.description
      content     = file(format("${path.module}/%s", x.filename))
      key         = x.key
      target_id   = x.target_id
    }
  }

  # Iterate and loop in the the content for the policies for tagging_policies
  tagging_policies = {
    for k, x in var.tagging_policies : k => {
      description = x.description
      content     = file(format("${path.module}/%s", x.filename))
      key         = x.key
      target_id   = x.target_id
    }
  }
}

## Provision the organization, policies and structure
module "organization" {
  source = "../.."

  backup_policies     = local.backup_policies
  enable_aws_services = var.enable_aws_services
  enable_delegation   = var.enable_delegation
  enable_policy_types = var.enable_policy_types
  #organization             = var.organization
  #service_control_policies = local.service_control_policies
  tagging_policies = local.tagging_policies
  tags             = var.tags
}
