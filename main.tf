
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

## Provision the observability centralization rules for the organization
resource "aws_observabilityadmin_centralization_rule_for_organization" "observability_centralization_rules" {
  for_each = var.observability_centralization_rules

  rule_name = each.key
  tags      = var.tags

  rule {
    source {
      regions = each.value.rule.source.regions
      scope   = each.value.rule.source.scope

      dynamic "source_logs_configuration" {
        for_each = each.value.rule.source.source_logs_configuration != null ? [1] : []
        content {
          encrypted_log_group_strategy = try(each.value.rule.source.source_logs_configuration.encrypted_log_group_strategy, null)
          log_group_selection_criteria = try(each.value.rule.source.source_logs_configuration.log_group_selection_criteria, null)
        }
      }
    }

    destination {
      region  = each.value.rule.destination.region
      account = each.value.rule.destination.account

      dynamic "destination_logs_configuration" {
        for_each = each.value.rule.destination.destination_logs_configuration != null ? [1] : []

        content {
          dynamic "logs_encryption_configuration" {
            for_each = each.value.rule.destination.destination_logs_configuration.logs_encryption_configuration != null ? [1] : []
            content {
              encryption_strategy                     = try(each.value.rule.destination.destination_logs_configuration.logs_encryption_configuration.encryption_strategy, null)
              encryption_conflict_resolution_strategy = try(each.value.rule.destination.destination_logs_configuration.logs_encryption_configuration.encryption_conflict_resolution_strategy, null)
              kms_key_arn                             = try(each.value.rule.destination.destination_logs_configuration.logs_encryption_configuration.kms_key_arn, null)
            }
          }

          dynamic "backup_configuration" {
            for_each = each.value.rule.destination.backup_configuration != null ? [1] : []
            content {
              region      = try(each.value.rule.destination.backup_configuration.region, null)
              kms_key_arn = try(each.value.rule.destination.backup_configuration.kms_key_arn, null)
            }
          }
        }
      }
    }
  }
}
