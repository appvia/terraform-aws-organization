
## Delegate the audit manager service
resource "aws_auditmanager_organization_admin_account_registration" "audit_manager" {
  count = var.enable_delegation.audit_manager != null ? 1 : 0

  admin_account_id = var.enable_delegation.audit_manager.account_id
}

## Delegate the access analyzer to the account
resource "aws_organizations_delegated_administrator" "access_analyzer_administrator" {
  count = var.enable_delegation.access_analyzer != null ? 1 : 0

  account_id        = var.enable_delegation.access_analyzer.account_id
  service_principal = "access-analyzer.amazonaws.com"
}

## Provision the service linked role when access analyzer is enabled
resource "aws_iam_service_linked_role" "access_analyzer" {
  count = var.enable_delegation.access_analyzer != null ? 1 : 0

  aws_service_name = "access-analyzer.amazonaws.com"
  description      = "Service-Linked Role for Access Analyzer, used by the landing zone"
  tags             = var.tags
}

## Delegate the cloudformation stacksets to the account
resource "aws_organizations_delegated_administrator" "stacksets_administrator" {
  count = var.enable_delegation.stacksets != null ? 1 : 0

  account_id        = var.enable_delegation.stacksets.account_id
  service_principal = "member.org.stacksets.cloudformation.amazonaws.com"
}

## Delegate the organization to the account
resource "aws_organizations_delegated_administrator" "delegated_administrator" {
  count = var.enable_delegation.organizations != null ? 1 : 0

  account_id        = var.enable_delegation.organizations.account_id
  service_principal = "principal"
}

## Delegate the detective service to the account
resource "aws_detective_organization_admin_account" "detective_organization_admin_account" {
  count = var.enable_delegation.detective != null ? 1 : 0

  account_id = var.enable_delegation.detective.account_id
}

## Delete the firewall manager to the account
resource "aws_fms_admin_account" "fms_admin_account" {
  count = var.enable_delegation.firewall_manager != null ? 1 : 0

  account_id = var.enable_delegation.firewall_manager.account_id
}

## Delegate the guardduty to the account
resource "aws_guardduty_organization_admin_account" "guardduty_organization_admin_account" {
  count = var.enable_delegation.guardduty != null ? 1 : 0

  admin_account_id = var.enable_delegation.guardduty.account_id
}

## Delegate the macie to the account
resource "aws_macie2_account" "macie" {
  count = var.enable_delegation.macie != null ? 1 : 0
}

## Delegate the macie to the account
resource "aws_macie2_organization_admin_account" "macie_organization_admin_account" {
  count = var.enable_delegation.macie != null ? 1 : 0

  admin_account_id = var.enable_delegation.macie.account_id
  depends_on       = [aws_macie2_account.macie]
}

## Delegate the securityhub to the account
resource "aws_securityhub_organization_admin_account" "securityhub_organization_admin_account" {
  count = var.enable_delegation.securityhub != null ? 1 : 0

  admin_account_id = var.enable_delegation.securityhub.account_id
}

## Delegate the IPAM to the account
resource "aws_vpc_ipam_organization_admin_account" "ipam_organization_admin_account" {
  count = var.enable_delegation.ipam != null ? 1 : 0

  delegated_admin_account_id = var.enable_delegation.ipam.account_id
}

## Delegate the inspection to the account_name
resource "aws_inspector2_delegated_admin_account" "inspection_organization_admin_account" {
  count = var.enable_delegation.inspector != null ? 1 : 0

  account_id = var.enable_delegation.inspector.account_id
}

resource "aws_organizations_delegated_administrator" "config_administrator" {
  count = var.enable_delegation.config != null ? 1 : 0

  account_id        = var.enable_delegation.config.account_id
  service_principal = "config.amazonaws.com"
}