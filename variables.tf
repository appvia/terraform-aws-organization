
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

  default = {}
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
    "RESOURCE_CONTROL_POLICY",
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
  ]
}

variable "resource_control_policies" {
  description = "A map of resource control policies to apply to the organization's root."
  type = map(object({
    description = string
    # A description for the resource control policy
    content = string
    # The content of the resource control policy
    key = optional(string)
    # If we created the organizational unit, this is the key to attach the policy to
    target_id = optional(string)
    # If the organizational unit already exists, this is the target ID to attach the policy to
  }))
  default = {}
}

variable "tagging_policies" {
  description = "A map of tagging policies to apply to the organization's root."
  type = map(object({
    description = string
    # A description for the tagging policy
    content = string
    # The content of the tagging policy
    key = optional(string)
    # If we created the organizational unit, this is the key to attach the policy to
    target_id = optional(string)
    # If the organizational unit already exists, this is the target ID to attach the policy to
  }))
  default = {}
}

variable "backup_policies" {
  description = "A map of backup policies to apply to the organization's root."
  type = map(object({
    description = string
    # A description for the backup policy
    content = string
    # The content of the backup policy
    key = optional(string)
    # If we created the organizational unit, this is the key to attach the policy to
    target_id = optional(string)
    # If the organizational unit already exists, this is the target ID to attach the policy to
  }))
  default = {}
}

variable "service_control_policies" {
  description = "A map of service control policies (SCPs) to apply to the organization's root."
  type = map(object({
    description = string
    # A description for the service control policy
    content = string
    # The content of the service control policy
    key = optional(string)
    # If we created the organizational unit, this is the key to attach the policy to
    target_id = optional(string)
    # If the organizational unit already exists, this is the target ID to attach the policy to
  }))
  default = {}
}

variable "enable_delegation" {
  description = "Provides at the capability to delegate the management of a service to another AWS account."
  type = object({
    access_analyzer = optional(object({
      account_id = string
      # The id of the account to delegate the management of Access Analyzer to
    }), null)
    guardduty = optional(object({
      account_id = string
      # The id of the account to delegate the management of GuardDuty to
    }), null)
    inspection = optional(object({
      account_id = string
      # The id of the account to delegate the management of Inspector to
    }), null)
    ipam = optional(object({
      account_id = string
      # The id of the account to delegate the management of IPAM to
    }), null)
    macie = optional(object({
      account_id = string
      # The id of the account to delegate the management of Macie to
    }), null)
    organizations = optional(object({
      account_id = string
      # The id of the account to delegate the management of Organizations to
    }), null)
    securityhub = optional(object({
      account_id = string
      # The id of the account to delegate the management of Security Hub to
    }), null)
    stacksets = optional(object({
      account_id = string
      # The id of the account to delegate the management of StackSets to
    }), null)
  })
  default = {
    access_analyzer = null
    guardduty       = null
    inspection      = null
    ipam            = null
    macie           = null
    organizations   = null
    securityhub     = null
    stacksets       = null
  }
}
