
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "enable_delegation" {
  description = "Provides at the capability to delegate the management of a service to another AWS account."
  type = object({
    audit_manager = optional(object({
      account_name = string
      # The name of the account to delegate the management of Audit Manager to
    }), null)
    detective = optional(object({
      account_name = string
      # The name of the account to delegate the management of Detective to
    }), null)
    firewall_manager = optional(object({
      account_name = string
      # The name of the account to delegate the management of Firewall Manager to
    }), null)
    guardduty = optional(object({
      account_name = string
      # The name of the account to delegate the management of GuardDuty to
    }), null)
    inspector = optional(object({
      account_name = string
      # The name of the account to delegate the management of Inspector to
    }), null)
    ipam = optional(object({
      account_name = string
      # The name of the account to delegate the management of IPAM to
    }), null)
    organizations = optional(object({
      account_name = string
      # The name of the account to delegate the management of Organizations to
    }), null)
    macie = optional(object({
      account_name = string
      # The name of the account to delegate the management of Macie to
    }), null)
    securityhub = optional(object({
      account_name = string
      # The name of the account to delegate the management of Security Hub to
    }), null)
  })
  default = {
    audit_manager    = null
    detective        = null
    firewall_manager = null
    guardduty        = null
    inspector        = null
    ipam             = null
    macie            = null
    organizations    = null
    securityhub      = null
  }
}
