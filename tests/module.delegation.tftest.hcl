
run "basic" {
  command = plan

  module {
    source = "./modules/delegation"
  }

  variables {
    enable_delegation = {
      securityhub = {
        account_name = "Audit",
      },
      guardduty = {
        account_name = "Audit",
      },
    }

    tags = {
      "Environment" = "Development",
      "Owner"       = "DevOps",
    }
  }
}

mock_provider "aws" {
  mock_data "aws_organizations_organization" {
    defaults = {
      id                 = "o-1234567890"
      arn                = "arn:aws:organizations::1234567890:organization/o-1234567890"
      feature_set        = "ALL"
      master_account_arn = "arn:aws:organizations::1234567890:account/o-1234567890"
      roots = [
        {
          id = "r-123456789"
        }
      ]
    }
  }

  mock_data "aws_organizations_organizational_unit_descendant_accounts" {
    defaults = {
      accounts = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::1234567890:account/123456789012"
          email  = "test@email.com"
          name   = "Audit",
          status = "ACTIVE"
        }
      ]
    }
  }
}