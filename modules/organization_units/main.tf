
## Find the Organization
data "aws_organizations_organization" "this" {}

## Find all the organizational units
data "aws_organizations_organizational_units" "this" {
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

## Find the organizational units under the workloads OU
data "aws_organizations_organizational_units" "workloads" {
  count = var.enable_workloads ? 1 : 0

  parent_id = ([for x in data.aws_organizations_organizational_units.this.children : x.id if x.name == "Workloads"])[0]
}
