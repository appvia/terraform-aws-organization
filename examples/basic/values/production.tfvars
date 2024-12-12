
service_control_policies = {
  "deny-root" = {
    description = "Control policies applicable to all accounts",
    filename    = "assets/service-control-policies/deny-root.json",
    #key         = "root",
    target_id = "r-h53v"
  },
  "deny-iam" = {
    description = "Control policies applicable to all accounts",
    filename    = "assets/service-control-policies/deny-infrastructure.json",
    #key         = "infrastructure",
    target_id = "ou-h53v-hpdeb19n"
  },
}

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
  "member.org.stacksets.cloudformation.amazonaws.com",
  "tagpolicies.tag.amazonaws.com",
]

tags = {
  "Environment" = "Production",
  "Owner"       = "Engineering",
  "Product"     = "LandingZone"
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
