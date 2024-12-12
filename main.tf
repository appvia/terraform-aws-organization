
## Provision the organization, policies and structure
resource "aws_organizations_organization" "organization" {
  aws_service_access_principals = var.enable_aws_services
  enabled_policy_types          = var.enable_policy_types
  feature_set                   = "ALL"
}

## Provision the organization units from the organization
resource "aws_organizations_organizational_unit" "level_1_ous" {
  for_each  = { for record in local.level_1_ou_arguments : record.key => record }
  name      = each.value.name
  parent_id = aws_organizations_organization.organization.roots[0].id
}

## Provision the organization units from the organization at level 2
resource "aws_organizations_organizational_unit" "level_2_ous" {
  for_each  = { for record in local.level_2_ou_arguments : record.key => record }
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.level_1_ous[each.value.parent].id
}

## Provision the organization units from the organization at level 3
resource "aws_organizations_organizational_unit" "level_3_ous" {
  for_each  = { for record in local.level_3_ou_arguments : record.key => record }
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.level_2_ous[each.value.parent].id
}

## Provision the organization units from the organization at level 4
resource "aws_organizations_organizational_unit" "level_4_ous" {
  for_each  = { for record in local.level_4_ou_arguments : record.key => record }
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.level_3_ous[each.value.parent].id
}

## Provision the organization units from the organization at level 5
resource "aws_organizations_organizational_unit" "level_5_ous" {
  for_each  = { for record in local.level_5_ou_arguments : record.key => record }
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.level_4_ous[each.value.parent].id
}

## Enable Guarduty within the management account
resource "aws_guardduty_detector" "guarduty" {
  count = var.enable_guardduty ? 1 : 0

  enable                       = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  tags                         = var.tags
}

