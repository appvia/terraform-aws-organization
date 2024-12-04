
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "organization" {
  description = "The organization with the tree of organizational units and accounts to construct. Defaults to an object with an empty list of units and accounts"
  type = object({
    units = optional(list(object({
      name = string,
      key  = string,
      units = optional(list(object({
        name = string,
        key  = string,
        units = optional(list(object({
          name = string,
          key  = string,
          units = optional(list(object({
            name = string,
            key  = string,
            units = optional(list(object({
              name = string,
              key  = string,
            })), [])
          })), [])
        })), [])
      })), [])
    })), [])
  })

  default = {
    units = [
      {
        name = "Infrastructure",
        key  = "infrastructure",
      },
      {
        name = "Security",
        key  = "security",
      },
      {
        name = "Transitional"
        key  = "transitional",
      },
      {
        name = "Suspended",
        key  = "suspended",
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
    ]
  }
}

variable "enable_aws_services" {
  description = "A list of AWS services to enable for the organization."
  type        = list(string)
  default = [
    "access-analyzer.amazonaws.com",
    "account.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "compute-optimizer.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
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
}

variable "enable_policy_types" {
  description = "A list of policy types to enable for the organization."
  type        = list(string)
  default = [
    "AISERVICES_OPT_OUT_POLICY",
    "BACKUP_POLICY",
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
  ]
}

variable "tagging_policies" {
  description = "A list of tagging policies to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    content     = string
    target      = string
  }))
  default = []
}

variable "backup_policies" {
  description = "A list of backup policies to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    content     = string
    key         = string
  }))
  default = []
}

variable "service_control_policies" {
  description = "A list of service control policies (SCPs) to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    content     = string
    key         = string
  }))
  default = []
}

variable "enable_delegation" {
  description = "Provides at the capability to delegate the management of a service to another AWS account."
  type = object({
    organizations = optional(object({
      account_name = string
    }), null)
    securityhub = optional(object({
      account_name = string
    }), null)
    guardduty = optional(object({
      account_name = string
    }), null)
    ipam = optional(object({
      account_name = string
    }), null)
    macie = optional(object({
      account_name = string
    }), null)
    inspection = optional(object({
      account_name = string
    }), null)
  })
  default = {
    organizations = null
    securityhub   = null
    guardduty     = null
    ipam          = null
    macie         = null
    inspection    = null
  }
}
