
locals {
  ## Iterate the children of organizations units (if any)
  children = {
    for ou in try(data.aws_organizations_organizational_units.root.children, []) :
    ou.name => {
      id        = ou.id
      parent_id = ou.parent_id
      arn       = format("arn:aws:organizations::%s:ou/%s/%s", local.management_account_id, local.organizational_id, ou.id)
    }
  }
}

