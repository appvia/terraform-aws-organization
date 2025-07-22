## Provision any service control policies
resource "aws_organizations_policy" "service_control_policy" {
  for_each = var.service_control_policies

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "SERVICE_CONTROL_POLICY"
}

## Attach any service control policies to the organizational root
resource "aws_organizations_policy_attachment" "service_control_policy_attachment_root" {
  for_each = { for k, v in var.service_control_policies : k => v if v.key == "root" }

  policy_id = aws_organizations_policy.service_control_policy[each.key].id
  target_id = local.root_ou
}

## Attach any service control policies to the organization unit
resource "aws_organizations_policy_attachment" "service_control_policy_attachment" {
  for_each = { for k, v in var.service_control_policies : k => v if v.key != "root" }

  policy_id = aws_organizations_policy.service_control_policy[each.key].id
  target_id = coalesce(
    try(each.value.target_id, null),
    try(local.all_ou_attributes[each.value.key].id, null),
    try(local.current_units[each.value.key], null),
  )
}

#
## Provision any tagging policies
#
resource "aws_organizations_policy" "tagging_policy" {
  for_each = var.tagging_policies

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "TAG_POLICY"
}

## Attach any tagging policies to the organizational units
resource "aws_organizations_policy_attachment" "tagging_policy_attachment_root" {
  for_each = { for k, v in var.tagging_policies : k => v if v.key == "root" }

  policy_id = aws_organizations_policy.tagging_policy[each.key].id
  target_id = local.root_ou
}

resource "aws_organizations_policy_attachment" "tagging_policy_attachment" {
  for_each = { for k, v in var.tagging_policies : k => v if v.key != "root" }

  policy_id = aws_organizations_policy.tagging_policy[each.key].id
  target_id = coalesce(each.value.target_id, try(local.all_ou_attributes[each.value.key].id, null))

  depends_on = [
    aws_organizations_organizational_unit.level_1_ous,
    aws_organizations_organizational_unit.level_2_ous,
    aws_organizations_organizational_unit.level_3_ous,
    aws_organizations_organizational_unit.level_4_ous,
    aws_organizations_organizational_unit.level_5_ous
  ]
}

#
## Provision any backup policies
#
resource "aws_organizations_policy" "backup_policy" {
  for_each = { for x in var.backup_policies : x.name => x }

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "BACKUP_POLICY"
}

## Attach any backup policies to the organizational root
resource "aws_organizations_policy_attachment" "backup_policy_attachment_root" {
  for_each = { for x in var.backup_policies : x.name => x if x.key == "root" }

  policy_id = aws_organizations_policy.backup_policy[each.key].id
  target_id = local.root_ou
}

## Attach any backup policies to the organizational units
resource "aws_organizations_policy_attachment" "backup_policy_attachment" {
  for_each = { for x in var.backup_policies : x.name => x if x.key != "root" }

  policy_id = aws_organizations_policy.backup_policy[each.key].id
  target_id = coalesce(each.value.target_id, try(local.all_ou_attributes[each.value.key].id, null))

  depends_on = [
    aws_organizations_organizational_unit.level_1_ous,
    aws_organizations_organizational_unit.level_2_ous,
    aws_organizations_organizational_unit.level_3_ous,
    aws_organizations_organizational_unit.level_4_ous,
    aws_organizations_organizational_unit.level_5_ous
  ]
}

#
## Provision any resource control policies
#
resource "aws_organizations_policy" "resource_control_policy" {
  for_each = var.resource_control_policies

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "RESOURCE_CONTROL_POLICY"
}

## Attach any resource control policies to the organizational root
resource "aws_organizations_policy_attachment" "resource_control_policy_attachment_root" {
  for_each = { for k, v in var.resource_control_policies : k => v if v.key == "root" }

  policy_id = aws_organizations_policy.resource_control_policy[each.key].id
  target_id = local.root_ou
}

## Attach any resource control policies to the organizational units
resource "aws_organizations_policy_attachment" "resource_control_policy_attachment" {
  for_each = { for k, v in var.resource_control_policies : k => v if v.key != "root" }

  policy_id = aws_organizations_policy.resource_control_policy[each.key].id
  target_id = coalesce(
    try(each.value.target_id, null),
    try(local.all_ou_attributes[each.value.key].id, null),
    try(local.current_units[each.value.key], null),
  )

  depends_on = [
    aws_organizations_organizational_unit.level_1_ous,
    aws_organizations_organizational_unit.level_2_ous,
    aws_organizations_organizational_unit.level_3_ous,
    aws_organizations_organizational_unit.level_4_ous,
    aws_organizations_organizational_unit.level_5_ous
  ]
}

#
## Provision any AI opt-out policies
#
resource "aws_organizations_policy" "ai_opt_out_policy" {
  for_each = var.ai_opt_out_policy

  name        = each.key
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "AISERVICES_OPT_OUT_POLICY"
}

## Attach any AI opt-out policies to the organizational root
resource "aws_organizations_policy_attachment" "ai_opt_out_policy_attachment_root" {
  for_each = { for k, v in var.ai_opt_out_policy : k => v if v.key == "root" }

  policy_id = aws_organizations_policy.ai_opt_out_policy[each.key].id
  target_id = local.root_ou
}

## Attach any AI opt-out policies to the organizational units
resource "aws_organizations_policy_attachment" "ai_opt_out_policy_attachment" {
  for_each = { for k, v in var.ai_opt_out_policy : k => v if v.key != "root" }

  policy_id = aws_organizations_policy.ai_opt_out_policy[each.key].id
  target_id = coalesce(
    try(each.value.target_id, null),
    try(local.all_ou_attributes[each.value.key].id, null),
    try(local.current_units[each.value.key], null),
  )

  depends_on = [
    aws_organizations_organizational_unit.level_1_ous,
    aws_organizations_organizational_unit.level_2_ous,
    aws_organizations_organizational_unit.level_3_ous,
    aws_organizations_organizational_unit.level_4_ous,
    aws_organizations_organizational_unit.level_5_ous
  ]
}
