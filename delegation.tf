
## Delegate the organization to the account 
resource "aws_organizations_delegated_administrator" "delegated_administrator" {
  count = var.enable_delegation.organizations != null ? 1 : 0

  account_id        = local.all_member_accounts[var.enable_delegation.organizations.account_name].id
  service_principal = "principal"
}

## Delegate the guardduty to the account 
resource "aws_guardduty_organization_admin_account" "guardduty_organization_admin_account" {
  count = var.enable_delegation.guardduty != null ? 1 : 0

  admin_account_id = local.all_member_accounts[var.enable_delegation.guardduty.account_name].id
}

## Delegate the macie to the account 
resource "aws_macie2_account" "macie" {
  count = var.enable_delegation.macie != null ? 1 : 0
}

## Delegate the macie to the account
resource "aws_macie2_organization_admin_account" "macie_organization_admin_account" {
  count = var.enable_delegation.macie != null ? 1 : 0

  admin_account_id = local.all_member_accounts[var.enable_delegation.macie.account_name].id
  depends_on       = [aws_macie2_account.macie]
}

## Delegate the securityhub to the account
resource "aws_securityhub_organization_admin_account" "securityhub_organization_admin_account" {
  count = var.enable_delegation.securityhub != null ? 1 : 0

  admin_account_id = local.all_member_accounts[var.enable_delegation.securityhub.account_name].id
}

## Delegate the IPAM to the account 
resource "aws_vpc_ipam_organization_admin_account" "ipam_organization_admin_account" {
  count = var.enable_delegation.ipam != null ? 1 : 0

  delegated_admin_account_id = local.all_member_accounts[var.enable_delegation.ipam.account_name].id
}

## Delegate the inspection to the account_name
resource "aws_inspection_organization_admin_account" "inspection_organization_admin_account" {
  count = var.enable_delegation.inspection != null ? 1 : 0

  admin_account_id = local.all_member_accounts[var.enable_delegation.inspection.account_name].id
}
