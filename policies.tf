#
## Provision any service control policies 
#
resource "aws_organizations_policy" "service_control_policy" {
  for_each = { for x in var.service_control_policies : x.name => x }

  name        = each.value.name
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "SERVICE_CONTROL_POLICY"
}

## Attach any service control policies to the organizational root
resource "aws_organizations_policy_attachment" "service_control_policy_attachment_root" {
  for_each = { for x in var.service_control_policies : x.name => x if x.target == "root" }

  policy_id = aws_organizations_policy.service_control_policy[each.key].id
  target_id = 
}

## Attach any service control policies to the organization unit 
resource "aws_organizations_policy_attachment" "service_control_policy_attachment" {
  for_each = { for x in var.service_control_policies : x.name => x if x.target != "root" }

  policy_id = aws_organizations_policy.service_control_policy[each.key].id
  target_id = local.all_ou_attributes[each.value.target].id
}

#
## Provision any tagging policies 
#
resource "aws_organizations_policy" "tagging_policy" {
  for_each = { for x in var.tagging_policies : x.name => x }

  name        = each.value.name
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "TAG_POLICY"
}

## Attach any tagging policies to the organizational units 
resource "aws_organizations_policy_attachment" "tagging_policy_attachment_root" {
  for_each = { for x in var.tagging_policies : x.name => x if x.target == "root" }

  policy_id = aws_organizations_policy.tagging_policy[each.key].id
  target_id = local.root_ou
}

resource "aws_organizations_policy_attachment" "tagging_policy_attachment" {
  for_each = { for x in var.tagging_policies : x.name => x if x.target != "root" }

  policy_id = aws_organizations_policy.tagging_policy[each.key].id
  target_id = local.all_ou_attributes[each.value.target].id
}

#
## Provision any backup policies 
#
resource "aws_organizations_policy" "backup_policy" {
  for_each = { for x in var.backup_policies : x.name => x }

  name        = each.value.name
  content     = each.value.content
  description = each.value.description
  tags        = var.tags
  type        = "BACKUP_POLICY"
}

## Attach any backup policies to the organizational root 
resource "aws_organizations_policy_attachment" "backup_policy_attachment_root" {
  for_each = { for x in var.backup_policies : x.name => x if x.target == "root" }

  policy_id = aws_organizations_policy.backup_policy[each.key].id
  target_id = local.root_ou
}

## Attach any backup policies to the organizational units
resource "aws_organizations_policy_attachment" "backup_policy_attachment" {
  for_each = { for x in var.backup_policies : x.name => x if x.target != "root" }

  policy_id = aws_organizations_policy.backup_policy[each.key].id
  target_id = local.all_ou_attributes[each.value.target].id
}

