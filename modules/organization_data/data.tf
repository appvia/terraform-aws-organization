
## Find the Organization
data "aws_organizations_organization" "this" {}

## Find all the organizational units
data "aws_organizations_organizational_units" "this" {
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

