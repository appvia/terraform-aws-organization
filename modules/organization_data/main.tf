
## Retrieve the organizational units from each of the roots
module "root_level_0" {
  for_each = local.root_organizational_units_parent_ids
  source   = "./modules/organizational_units"

  parent_id = each.value
}

## Retrieve the the second level from each of the roots
module "root_level_1" {
  for_each = module.root_level_0.organizational_unit_ids.children
  source   = "./modules/organizational_units"

  parent_id = each.value.parent_id
}

## Retrieve the the third level from each of the roots
module "root_level_2" {
  for_each = module.root_level_1.organizational_unit_ids.children
  source   = "./modules/organizational_units"

  parent_id = each.value.parent_id
}

## Retrieve the the fourth level from each of the roots
module "root_level_3" {
  for_each = module.root_level_2.organizational_unit_ids.children
  source   = "./modules/organizational_units"

  parent_id = each.value.parent_id
}

## Retrieve the the fifth level from each of the roots
module "root_level_4" {
  for_each = module.root_level_3.organizational_unit_ids.children
  source   = "./modules/organizational_units"

  parent_id = each.value.parent_id
}
