
locals {
  ## The manganese account ID
  management_account_id = data.aws_organizations_organization.this.master_account_id

  ## The organizational id
  organizational_id = data.aws_organizations_organization.this.id

  ## Organization parent id
  organization_parent_id = data.aws_organizations_organization.this.roots[0].id

  ## Build a map of the organizational units parent ids from the root
  root_organizational_units_parent_ids = {
    for ou in data.aws_organizations_organizational_units.this.children :
    ou.name => ou.parent_id
  }

  ## Build a map of the organizational units
  root_organizational_units = {
    for ou in data.aws_organizations_organizational_units.this.children :
    ou.name => format("arn:aws:organizations::%s:ou/%s/%s", local.management_account_id, local.organizational_id, ou.id)
  }

  ## Workloads organizational unit
  workloads_organizational_units = {
    for ou in data.aws_organizations_organizational_units.workloads.children :
    ou.name => format("arn:aws:organizations::%s:ou/%s/%s", local.management_account_id, local.organizational_id, ou.id)
  }
}

