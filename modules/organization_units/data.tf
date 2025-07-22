
## Find the organizational units under the workloads OU
data "aws_organizations_organizational_units" "root" {
  parent_id = var.parent_id
}

## Find the organizational
data
