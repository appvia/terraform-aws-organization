
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "tagging_policies" {
  description = "A list of tagging policies to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    filename    = string
    target_id   = string
  }))
  default = []
}

variable "backup_policies" {
  description = "A list of backup policies to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    filename    = string
    target_id   = string
  }))
  default = []
}

variable "service_control_policies" {
  description = "A list of service control policies (SCPs) to apply to the organization's root."
  type = list(object({
    name        = string
    description = string
    filename    = string
    target_id   = string
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
  })
}

variable "enable_policy_types" {
  description = "The list of Organizations policy types to enable in the organization."
  type        = list(string)
  default = [
    "BACKUP_POLICY",
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
  ]
}

variable "organization_units" {
  description = "The organization with the tree of organizational units"
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
  default  = {}
  nullable = false
}

