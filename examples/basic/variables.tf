
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "tagging_policies" {
  description = "A list of tagging policies to apply to the organization's root."
  type = map(object({
    description = string
    filename    = string
    key         = optional(string)
    target_id   = optional(string)
  }))
  default = {}
}

variable "enable_aws_services" {
  description = "The list of AWS services to enable in the organization."
  type        = list(string)
  default     = []
}

variable "backup_policies" {
  description = "A list of backup policies to apply to the organization's root."
  type = map(object({
    description = string
    filename    = string
    key         = optional(string)
    target_id   = optional(string)
  }))
  default = {}
}

variable "service_control_policies" {
  description = "A list of service control policies (SCPs) to apply to the organization's root."
  type = map(object({
    description = string
    filename    = string
    key         = optional(string)
    target_id   = optional(string)
  }))
  default = {}
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

variable "organization" {
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

