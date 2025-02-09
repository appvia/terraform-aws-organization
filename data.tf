
## Retrieve all of the current organizational units
data "aws_organizations_organizational_units" "current" {
  parent_id = aws_organizations_organization.organization.roots[0].id
}
