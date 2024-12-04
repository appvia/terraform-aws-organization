run "basic" {
  command = plan

  variables {
    enable_aws_services = [
      "access-analyzer.amazonaws.com",
      "account.amazonaws.com",
      "cloudtrail.amazonaws.com",
      "compute-optimizer.amazonaws.com",
      "config.amazonaws.com",
      "controltower.amazonaws.com",
      "cost-optimization-hub.bcm.amazonaws.com",
      "guardduty.amazonaws.com",
      "ram.amazonaws.com",
      "securityhub.amazonaws.com",
      "servicequotas.amazonaws.com",
      "sso.amazonaws.com",
      "tagpolicies.tag.amazonaws.com",
    ]

    organization = {
      units = [
        {
          name = "Infrastucture",
          key  = "infrastructure",
        },
        {
          name = "Workloads",
          key  = "workloads",
          units = [
            {
              name = "Development",
              key  = "workloads/development",
            },
            {
              name = "Production",
              key  = "workloads/production",
            },
          ]
        },
        {
          name = "Exceptions",
          key  = "exceptions",
        },
        {
          name = "Suspended",
          key  = "suspended",
        },
        {
          name = "Transitional",
          key  = "transitional",
        },
        {
          name = "Graveyard",
          key  = "graveyard",
        },
        {
          name = "Deployments",
          key  = "deployments",
        },
        {
          name = "Sandbox",
          key  = "sandbox",
        }
      ]
    }

    tags = {
      "Environment" = "Development",
      "Owner"       = "DevOps",
    }

  }
}

#mock_provider "aws" {
#  alias = "identity"
#
#  mock_data "aws_ssoadmin_instances" {
#    defaults = {
#      instances = [
#        {
#          id     = "ssoins-1234567890abcdef0"
#          name   = "default"
#          status = "ACTIVE"
#        }
#      ]
#      arns = [
#        "arn:aws:sso:::instance/ssoins-1234567890abcdef0"
#      ]
#      identity_store_ids = [
#        "ssoins-1234567890abcdeft"
#      ]
#    }
#  }
#}

mock_provider "aws" {
}
