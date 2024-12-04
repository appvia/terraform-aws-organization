
## Retrieve a list of all the accounts in the organization
data "aws_organizations_organizational_unit_descendant_accounts" "current" {
  parent_id = aws_organizations_organization.organization.roots[0].id
}

## Lookup up and build a map of all the organizational units within the organization
## using the keys as the organizational unit hirearchy key
data "aws_organizations_organizational_units" "current" {
  parent_id = aws_organizations_organization.organization.roots[0].id
}
