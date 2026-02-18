locals {
  ## The controls to enable for control tower, if specified
  control_tower_controls = try(var.control_tower.controls, null) != null ? {
    for control in var.control_tower.controls : control.identifier => control } : {}
}

## Provision the control tower control if specified
resource "aws_controltower_control" "controls" {
  for_each = local.control_tower_controls

  control_identifier = each.value.identifier
  target_identifier = coalesce(try(local.all_ou_attributes[each.value.target_identifier].id, null), each.value.target_identifier)

  dynamic "parameters" {
    for_each = try(each.value.parameters, [])
    content {
      key   = parameters.value.key
      value = jsonencode(parameters.value.value)
    }
  }

  depends_on = [ 
    aws_organizations_organizational_unit.level_1_ous,
    aws_organizations_organizational_unit.level_2_ous,
    aws_organizations_organizational_unit.level_3_ous,
    aws_organizations_organizational_unit.level_4_ous,
    aws_organizations_organizational_unit.level_5_ous,
  ]
}