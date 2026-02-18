
variable "tags" {
  description = "A map of tags to resources provisioned by this module."
  type        = map(string)
}

variable "control_tower" {
  description = "Configuration for AWS Control Tower service"
  type = object({
    # A list of controls to enable in the Control Tower landing zone. 
    controls = optional(list(object({
      # The identifier of the control to enable (e.g. "arn:aws:controltower:us-east-1::control/AWS-GR_EC2_VOLUME_INUSE_CHECK")
      identifier = string
      # The target identifier for the control - can be either the organization key (e.g. "workloads/production") which will be automatically resolved to the OU ID, or a direct OU ID (e.g. "ou-xxxxxxxxxx")
      target_identifier = string
      # A list of parameters to configure for the control.
      parameters = optional(list(object({
        # The key of the control parameter (e.g. "AllowedRegions")
        key = string
        # The value of the control parameter (e.g. ["us-east-1"])
        value = string
      })), [])
    })), [])
  })
  default = null
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

variable "observability_centralization_rules" {
  description = "A list of observability centralization rules to apply to the organization."
  type = map(object({
    # The name of the observability centralization rule
    rule = object({
      destination = object({
        # The region of the destination account
        region = list(string)
        # The account ID of the destination account
        account = string
        # The destination logs configuration
        destination_logs_configuration = optional(object({
          logs_encryption_strategy = optional(object({
            # The encrypted log group strategy (AWS_OWNED or CUSTOMER_MANAGED)
            encrypted_strategy = string
            # The encryption conflict resolution strategy (ALLOW or SKIP)
            encryption_conflict_resolution_strategy = string
            # The KMS key ARN for the log group, if CUSTOMER_MANAGED is selected
            kms_key_arn = optional(string, null)
          }), null)
          # The destination logs encryption configuration
          destination_logs_encryption_configuration = optional(object({
            # The encrypted log group strategy
            encrypted_log_group_strategy = string
            # The log group selection criteria
            log_group_selection_criteria = string
            # The KMS key ARN for the log group
            kms_key_arn = string
          }), null)
        }), null)
      })
      source = object({
        # The regions of the source accounts
        regions = list(string)
        # The scope of the source accounts (OrganizationId = 'o-example123456')
        scope = string
        # The source logs configuration
        source_logs_configuration = optional(object({
          # The encrypted log group strategy
          encrypted_log_group_strategy = string
          # The log group selection criteria
          log_group_selection_criteria = string
          # The KMS key ARN for the log group
          kms_key_arn = optional(string, null)
        }), null)
      })
    })
  }))
  default = {}
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

variable "ai_opt_out_policy" {
  description = "A map of AI services opt-out policies to apply to the organization's root."
  type = map(object({
    description = string
    # A description for the AI services opt-out policy
    content = string
    # The content of the AI services opt-out policy
    key = optional(string)
    # If we created the organizational unit, this is the key to attach the policy to
    target_id = optional(string)
    # If the organizational unit already exists, this is the target ID to attach the policy to
  }))
  default = {}
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
      # The id of the account to delegate the management of Access Analyzer to
      account_id = string
    }), null)
    cloudtrail = optional(object({
      # The id of the account to delegate the management of CloudTrail to
      account_id = string
    }), null)
    guardduty = optional(object({
      # The id of the account to delegate the management of GuardDuty to
      account_id = string
    }), null)
    inspection = optional(object({
      # The id of the account to delegate the management of Inspector to
      account_id = string
    }), null)
    ipam = optional(object({
      # The id of the account to delegate the management of IPAM to
      account_id = string
    }), null)
    macie = optional(object({
      # The id of the account to delegate the management of Macie to
      account_id = string
    }), null)
    organizations = optional(object({
      # The id of the account to delegate the management of Organizations to
      account_id = string
    }), null)
    securityhub = optional(object({
      # The id of the account to delegate the management of Security Hub to
      account_id = string
    }), null)
    stacksets = optional(object({
      # The id of the account to delegate the management of StackSets to
      account_id = string
    }), null)
    config = optional(object({
      # The id of the account to delegate the management of Config to
      account_id = string
    }), null)
  })
  default = {
    access_analyzer = null
    cloudtrail      = null
    guardduty       = null
    inspection      = null
    ipam            = null
    macie           = null
    organizations   = null
    securityhub     = null
    stacksets       = null
    config          = null
  }
}
