
run "basic" {
  command = plan

  variables {
    organization = {
      units = [
        {
          name = "Infrastucture",
          key  = "infrastructure",
        },
      ]
    }

    service_control_policies = {
      "deny-infrastructure" = {
        description = "Apply to a organizational unit we created",
        content     = "{}",
        key         = "infrastructure"
      },
      "deny-security" = {
        description = "Control policies applicable to all accounts",
        content     = "{}",
        key         = "Security"
      },
    }

    tags = {
      "Environment" = "Development",
      "Owner"       = "DevOps",
    }
  }
}

mock_provider "aws" {
}

mock_provider "aws" {
  alias = "us-east-1"
}
