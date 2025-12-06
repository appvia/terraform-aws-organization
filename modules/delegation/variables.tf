
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "enable_delegation" {
  description = "Provides at the capability to delegate the management of a service to another AWS account."
  type = object({
    access_analyzer = optional(object({
      # The account id of the account to delegate the management of Access Analyzer to
      account_id = string
    }), null)
    audit_manager = optional(object({
      # The account id of the account to delegate the management of Audit Manager to
      account_id = string
    }), null)
    cloudtrail = optional(object({
      # The account id of the account to delegate the management of CloudTrail to
      account_id = string
    }), null)
    detective = optional(object({
      # The account id of the account to delegate the management of Detective to
      account_id = string
    }), null)
    firewall_manager = optional(object({
      # The account id of the account to delegate the management of Firewall Manager to
      account_id = string
    }), null)
    guardduty = optional(object({
      # The account id of the account to delegate the management of GuardDuty to
      account_id = string
    }), null)
    inspector = optional(object({
      # The account id of the account to delegate the management of Inspector to
      account_id = string
    }), null)
    ipam = optional(object({
      # The account id of the account to delegate the management of IPAM to
      account_id = string
    }), null)
    organizations = optional(object({
      # The account id of the account to delegate the management of Organizations to
      account_id = string
    }), null)
    macie = optional(object({
      # The account id of the account to delegate the management of Macie to
      account_id = string
    }), null)
    securityhub = optional(object({
      # The account id of the account to delegate the management of Security Hub to
      account_id = string
    }), null)
    stacksets = optional(object({
      # The account id of the account to delegate the management of StackSets to
      account_id = string
    }), null)
    config = optional(object({
      # The id of the account to delegate the management of Config to
      account_id = string
    }), null)
  })
  default = {
    access_analyzer  = null
    audit_manager    = null
    cloudtrail       = null
    detective        = null
    firewall_manager = null
    guardduty        = null
    inspector        = null
    ipam             = null
    macie            = null
    organizations    = null
    securityhub      = null
    stacksets        = null
    config           = null
  }
}
