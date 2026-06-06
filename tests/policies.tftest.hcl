
run "basic" {
  command = plan

  variables {
    enable_policy_types = [
      "DECLARATIVE_POLICY_EC2",
      "RESOURCE_CONTROL_POLICY",
      "SERVICE_CONTROL_POLICY",
      "TAG_POLICY",
    ]

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

    resource_control_policies = {
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

    ec2_policies = {
      "deny-public-snapshot-block" = {
        description = "Controls if Amazon EBS snapshots are publicly accessible."
        content = jsonencode({
          ec2_attributes = {
            snapshot_block_public_access = {
              state = {
                "@@assign" = "block_new_sharing"
              }
            }
          }
        })
        key = "infrastructure"
      }
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
