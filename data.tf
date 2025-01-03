
## Retrieve a list of all the accounts in the organization
data "aws_organizations_organizational_unit_descendant_accounts" "current" {
  parent_id = aws_organizations_organization.organization.roots[0].id
}

## Retrieve all of the current organizational units
data "aws_organizations_organizational_units" "current" {
  parent_id = aws_organizations_organization.organization.roots[0].id
}
