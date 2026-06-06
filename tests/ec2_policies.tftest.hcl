run "ec2_policies_attach_to_organizational_unit" {
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
          name = "Workloads"
          key  = "workloads"
        },
      ]
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
        key = "workloads"
      }
      "deny-public-image-block" = {
        description = "Controls if Amazon Machine Images (AMIs) are publicly sharable."
        content = jsonencode({
          ec2_attributes = {
            image_block_public_access = {
              state = {
                "@@assign" = "block_new_sharing"
              }
            }
          }
        })
        key = "workloads"
      }
    }

    tags = {
      Environment = "Test"
      Owner       = "DevOps"
    }
  }

  assert {
    condition     = length(aws_organizations_policy.ec2_policy) == 2
    error_message = "Expected two EC2 declarative policies to be created"
  }

  assert {
    condition     = aws_organizations_policy.ec2_policy["deny-public-snapshot-block"].type == "DECLARATIVE_POLICY_EC2"
    error_message = "Snapshot block policy must use the DECLARATIVE_POLICY_EC2 policy type"
  }

  assert {
    condition     = aws_organizations_policy.ec2_policy["deny-public-image-block"].type == "DECLARATIVE_POLICY_EC2"
    error_message = "Image block policy must use the DECLARATIVE_POLICY_EC2 policy type"
  }

  assert {
    condition     = can(jsondecode(aws_organizations_policy.ec2_policy["deny-public-snapshot-block"].content).ec2_attributes.snapshot_block_public_access.state["@@assign"])
    error_message = "Snapshot block policy content must define snapshot_block_public_access"
  }

  assert {
    condition     = jsondecode(aws_organizations_policy.ec2_policy["deny-public-snapshot-block"].content).ec2_attributes.snapshot_block_public_access.state["@@assign"] == "block_new_sharing"
    error_message = "Snapshot block policy content must block new public sharing"
  }

  assert {
    condition     = jsondecode(aws_organizations_policy.ec2_policy["deny-public-image-block"].content).ec2_attributes.image_block_public_access.state["@@assign"] == "block_new_sharing"
    error_message = "Image block policy content must block new public sharing"
  }

  assert {
    condition     = length(aws_organizations_policy_attachment.ec2_policy_attachment) == 2
    error_message = "Expected both EC2 policies to attach to the workloads organizational unit"
  }

  assert {
    condition     = contains(keys(aws_organizations_policy_attachment.ec2_policy_attachment), "deny-public-snapshot-block")
    error_message = "Snapshot block policy attachment must be created"
  }

  assert {
    condition     = contains(keys(aws_organizations_policy_attachment.ec2_policy_attachment), "deny-public-image-block")
    error_message = "Image block policy attachment must be created"
  }

  assert {
    condition     = aws_organizations_policy.ec2_policy["deny-public-snapshot-block"].description == "Controls if Amazon EBS snapshots are publicly accessible."
    error_message = "Snapshot block policy description must match the configured value"
  }

  assert {
    condition     = aws_organizations_policy.ec2_policy["deny-public-image-block"].description == "Controls if Amazon Machine Images (AMIs) are publicly sharable."
    error_message = "Image block policy description must match the configured value"
  }
}

run "ec2_policies_attach_to_root" {
  command = plan

  variables {
    enable_policy_types = [
      "DECLARATIVE_POLICY_EC2",
      "SERVICE_CONTROL_POLICY",
    ]

    organization = {
      units = []
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
        key = "root"
      }
    }

    tags = {
      Environment = "Test"
      Owner       = "DevOps"
    }
  }

  assert {
    condition     = length(aws_organizations_policy_attachment.ec2_policy_attachment_root) == 1
    error_message = "Expected root-level EC2 policy attachment when key is root"
  }

  assert {
    condition     = contains(keys(aws_organizations_policy_attachment.ec2_policy_attachment_root), "deny-public-snapshot-block")
    error_message = "Root EC2 policy attachment must be created for the snapshot block policy"
  }

  assert {
    condition     = length(aws_organizations_policy_attachment.ec2_policy_attachment) == 0
    error_message = "Root EC2 policies must not create organizational unit attachments"
  }
}

mock_provider "aws" {
}

mock_provider "aws" {
  alias = "us-east-1"
}
