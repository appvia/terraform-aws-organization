
service_control_policies = [
  {
    name        = "deny-root",
    description = "Control policies applicable to all accounts",
    filename    = "assets/service-control-policies/deny-root.json",
    target      = "root",
  },
  {
    name        = "deny-iam",
    description = "Control policies applicable to all accounts",
    filename    = "assets/service-control-policies/deny-infrastructure.json",
    target      = "infrastructure",
  },
]

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

tags = {
  "Environment" = "Development",
  "Owner"       = "DevOps",
}

enable_delegation = {
  securityhub = {
    account_name = "Audit",
  },
  guardduty = {
    account_name = "Audit",
  },
}

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
