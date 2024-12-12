
locals {
  ## All member accounts in the organization which are active
  all_member_accounts = {
    for x in data.aws_organizations_organizational_unit_descendant_accounts.current.accounts :
    x.name => {
      arn    = x.arn
      email  = x.email
      id     = x.id
      name   = x.name
      status = x.status
    } if x.status == "ACTIVE"
  }
}
