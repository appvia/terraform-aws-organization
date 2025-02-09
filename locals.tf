locals {
  ## Build a map of the service quotas
  service_quotas = {
    for quota in var.service_quotas : "${quota.service_code}-${quota.quota_code}" => {
      service_code = quota.service_code
      quota_code   = quota.quota_code
      value        = quota.value
    }
  }

  ## Build of a map of all the organizational units from the data lookup
  current_units = {
    for ou in data.aws_organizations_organizational_units.current.children : lower(ou.name) => ou.id
  }

  ## The root organizational unit
  root_ou = aws_organizations_organization.organization.roots[0].id

  ## Build all the level 1 organizational units
  level_1_ou_arguments = [
    for ou in var.organization.units :
    {
      name : ou.name,
      key : ou.key,
    }
  ]
  ## Build all the level 2 organizational units
  level_2_ou_arguments = flatten([
    for level_1_ou in var.organization.units :
    [
      for level_2_ou in level_1_ou.units :
      {
        name : level_2_ou.name,
        key : level_2_ou.key,
        parent : level_1_ou.key
      }
    ]
  ])
  ## Build all the level 3 organizational units
  level_3_ou_arguments = flatten([
    for level_1_ou in var.organization.units :
    [
      for level_2_ou in level_1_ou.units :
      [
        for level_3_ou in level_2_ou.units :
        {
          name : level_3_ou.name,
          key : level_3_ou.key,
          parent : level_2_ou.key
        }
      ]
    ]
  ])
  ## Build all the level 4 organizational units
  level_4_ou_arguments = flatten([
    for level_1_ou in var.organization.units :
    [
      for level_2_ou in level_1_ou.units :
      [
        for level_3_ou in level_2_ou.units :
        [
          for level_4_ou in level_3_ou.units :
          {
            name : level_4_ou.name,
            key : level_4_ou.key,
            parent : level_3_ou.key
          }
        ]
      ]
    ]
  ])
  ## Build all the level 5 organizational units
  level_5_ou_arguments = flatten([
    for level_1_ou in var.organization.units :
    [
      for level_2_ou in level_1_ou.units :
      [
        for level_3_ou in level_2_ou.units :
        [
          for level_4_ou in level_3_ou.units :
          [
            for level_5_ou in level_4_ou.units :
            {
              name : level_5_ou.name,
              key : level_5_ou.key,
              parent : level_4_ou.key
            }
          ]
        ]
      ]
    ]
  ])
}

locals {
  level_1_ou_attributes = [
    for ou in local.level_1_ou_arguments :
    {
      key       = ou.key
      id        = aws_organizations_organizational_unit.level_1_ous[ou.key].id,
      arn       = aws_organizations_organizational_unit.level_1_ous[ou.key].arn,
      parent_id = aws_organizations_organizational_unit.level_1_ous[ou.key].parent_id,
      name      = aws_organizations_organizational_unit.level_1_ous[ou.key].name,
    }
  ]
  level_2_ou_attributes = [
    for ou in local.level_2_ou_arguments :
    {
      key       = ou.key
      id        = aws_organizations_organizational_unit.level_2_ous[ou.key].id,
      arn       = aws_organizations_organizational_unit.level_2_ous[ou.key].arn,
      parent_id = aws_organizations_organizational_unit.level_2_ous[ou.key].parent_id,
      name      = aws_organizations_organizational_unit.level_2_ous[ou.key].name,
    }
  ]
  level_3_ou_attributes = [
    for ou in local.level_3_ou_arguments :
    {
      key       = ou.key
      id        = aws_organizations_organizational_unit.level_3_ous[ou.key].id,
      arn       = aws_organizations_organizational_unit.level_3_ous[ou.key].arn,
      parent_id = aws_organizations_organizational_unit.level_3_ous[ou.key].parent_id,
      name      = aws_organizations_organizational_unit.level_3_ous[ou.key].name,
    }
  ]
  level_4_ou_attributes = [
    for ou in local.level_4_ou_arguments :
    {
      key       = ou.key
      id        = aws_organizations_organizational_unit.level_4_ous[ou.key].id,
      arn       = aws_organizations_organizational_unit.level_4_ous[ou.key].arn,
      parent_id = aws_organizations_organizational_unit.level_4_ous[ou.key].parent_id,
      name      = aws_organizations_organizational_unit.level_4_ous[ou.key].name,
    }
  ]
  level_5_ou_attributes = [
    for ou in local.level_5_ou_arguments :
    {
      key       = ou.key
      id        = aws_organizations_organizational_unit.level_5_ous[ou.key].id,
      arn       = aws_organizations_organizational_unit.level_5_ous[ou.key].arn,
      parent_id = aws_organizations_organizational_unit.level_5_ous[ou.key].parent_id,
      name      = aws_organizations_organizational_unit.level_5_ous[ou.key].name,
    }
  ]
  all_ou_attributes = {
    for ou in concat(
      local.level_1_ou_attributes,
      local.level_2_ou_attributes,
      local.level_3_ou_attributes,
      local.level_4_ou_attributes,
      local.level_5_ou_attributes
    ) :
    ou.key => ou
  }
}
