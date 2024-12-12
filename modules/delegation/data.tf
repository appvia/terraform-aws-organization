
## Find the organization
data "aws_organizations_organization" "organization" {}

## Retrieve a list of all the accounts in the organization
data "aws_organizations_organizational_unit_descendant_accounts" "current" {
  parent_id = data.aws_organizations_organization.organization.roots[0].id
}
