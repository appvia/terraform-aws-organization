![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Organization Module

## Description

The purpose of this module is to create an AWS organization with a tree of organizational units and accounts. The module also provides the capability to enable AWS services, policy types, and delegation of services to other AWS accounts.

### Organizational Units

You can defined your organizational units in the `organization` input variable. The `organization` input variable is an object with a list of units and accounts. Each unit can have a list of sub-units. The `organization` input variable defaults to an object with an empty list of units and accounts. An example is provided below

```hcl
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
      name = "Sandbox",
      key  = "sandbox",
    }
  ]

```

### Organizational Features

The `enable_aws_services` input variable is a list of AWS services to enable for the organization. The `enable_policy_types` input variable is a list of policy types to enable for the organization. The `enable_delegation` input variable provides the capability to delegate the management of a service to another AWS account. An example is provided below

```hcl
enable_aws_services = [
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
  "tagpolicies.tag.amazonaws.com"
]

enable_policy_types = [
  "AISERVICES_OPT_OUT_POLICY",
  "BACKUP_POLICY",
  "SERVICE_CONTROL_POLICY",
  "TAG_POLICY"
]

enable_delegation = {
  organizations = {
    account_name = "Audit"
  }
  securityhub = {
    account_name = "Audit"
  }
  guardduty = {
    account_name = "Audit"
  }
  ipam = {
    account_name = "Network"
  }
  macie = {
    account_name = "Audit"
  }
  inspection = {
    account_name = "Audit"
  }
}
```

### Service Control Policies

You can attach service control policies (SCPs) to the organization's root or to specific organizational units. The `service_control_policies` input variable is a map of SCPs to apply to the organization's root. The map key is the name of the SCP and the value is an object with the following attributes:

- `description` - A description for the SCP
- `content` - The content of the SCP
- `key` - If we created the organizational unit, this is the key to attach the policy to
- `target_id` - If the organizational unit already exists, this is the target ID to attach the policy to

An example where is have created the organizational units below

```
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
          name = "Production",
          key  = "workloads/production",
        },
      ]
    }
  ]
}

## Checkout the basic example for more details
service_control_policies = {
  "DenyAll" = {
    description = "Deny all actions"
    content     = file("${path.module}/policies/deny-all.json")
    key         = "infrastructure"
  }
  "DenyProduction" = {
    description = "Deny all actions in the infrastructure unit"
    content     = file("${path.module}/policies/deny-infrastructure.json")
    key         = "infrastructure/production"
  }
}
```

Alternatively if the organizational unit already exists, you can attach the SCP to the target ID. An example is provided below

```
service_control_policies = {
  "DenyAll" = {
    description = "Deny all actions"
    content     = file("${path.module}/policies/deny-all.json")
    target_id   = "ou-123456789012"
  }
}
```

### Backup Policies

Backup policies can be attached to the organization's root or to specific organizational units. The `backup_policies` input variable is a map of backup policies to apply to the organization's root. The map key is the name of the backup policy and the value is an object with the following attributes:

- `description` - A description for the backup policy
- `content` - The content of the backup policy
- `key` - If we created the organizational unit, this is the key to attach the policy to
- `target_id` - If the organizational unit already exists, this is the target ID to attach the policy to

An example where is have created the organizational units below

```
organization = {
  units = [
    {
      name = "Infrastucture",
      key  = "infrastructure",
    }
  ]
}

backup_policies = {
  "BackupAll" = {
    description = "Backup all resources"
    content     = file("${path.module}/policies/backup-all.json")
    key         = "infrastructure"
    # target_id   = "ou-123456789012" # If the organizational unit already exists
  }
}
```

## Usage

Add example usage here

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to resources provisioned by this module. | `map(string)` | n/a | yes |
| <a name="input_backup_policies"></a> [backup\_policies](#input\_backup\_policies) | A map of backup policies to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    # A description for the backup policy<br/>    content = string<br/>    # The content of the backup policy<br/>    key = optional(string)<br/>    # If we created the organizational unit, this is the key to attach the policy to<br/>    target_id = optional(string)<br/>    # If the organizational unit already exists, this is the target ID to attach the policy to<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_aws_services"></a> [enable\_aws\_services](#input\_enable\_aws\_services) | A list of AWS services to enable for the organization. | `list(string)` | <pre>[<br/>  "access-analyzer.amazonaws.com",<br/>  "account.amazonaws.com",<br/>  "cloudtrail.amazonaws.com",<br/>  "compute-optimizer.amazonaws.com",<br/>  "config-multiaccountsetup.amazonaws.com",<br/>  "config.amazonaws.com",<br/>  "controltower.amazonaws.com",<br/>  "cost-optimization-hub.bcm.amazonaws.com",<br/>  "guardduty.amazonaws.com",<br/>  "ram.amazonaws.com",<br/>  "securityhub.amazonaws.com",<br/>  "servicequotas.amazonaws.com",<br/>  "sso.amazonaws.com",<br/>  "tagpolicies.tag.amazonaws.com"<br/>]</pre> | no |
| <a name="input_enable_delegation"></a> [enable\_delegation](#input\_enable\_delegation) | Provides at the capability to delegate the management of a service to another AWS account. | <pre>object({<br/>    organizations = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Organizations to<br/>    }), null)<br/>    securityhub = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Security Hub to<br/>    }), null)<br/>    guardduty = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of GuardDuty to<br/>    }), null)<br/>    ipam = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of IPAM to<br/>    }), null)<br/>    macie = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Macie to<br/>    }), null)<br/>    inspection = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Inspector to<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "guardduty": null,<br/>  "inspection": null,<br/>  "ipam": null,<br/>  "macie": null,<br/>  "organizations": null,<br/>  "securityhub": null<br/>}</pre> | no |
| <a name="input_enable_policy_types"></a> [enable\_policy\_types](#input\_enable\_policy\_types) | A list of policy types to enable for the organization. | `list(string)` | <pre>[<br/>  "AISERVICES_OPT_OUT_POLICY",<br/>  "BACKUP_POLICY",<br/>  "RESOURCE_CONTROL_POLICY",<br/>  "SERVICE_CONTROL_POLICY",<br/>  "TAG_POLICY"<br/>]</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The organization with the tree of organizational units and accounts to construct. Defaults to an object with an empty list of units and accounts | <pre>object({<br/>    units = optional(list(object({<br/>      name = string,<br/>      key  = string,<br/>      units = optional(list(object({<br/>        name = string,<br/>        key  = string,<br/>        units = optional(list(object({<br/>          name = string,<br/>          key  = string,<br/>          units = optional(list(object({<br/>            name = string,<br/>            key  = string,<br/>            units = optional(list(object({<br/>              name = string,<br/>              key  = string,<br/>            })), [])<br/>          })), [])<br/>        })), [])<br/>      })), [])<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_service_control_policies"></a> [service\_control\_policies](#input\_service\_control\_policies) | A map of service control policies (SCPs) to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    # A description for the service control policy<br/>    content = string<br/>    # The content of the service control policy<br/>    key = optional(string)<br/>    # If we created the organizational unit, this is the key to attach the policy to<br/>    target_id = optional(string)<br/>    # If the organizational unit already exists, this is the target ID to attach the policy to<br/>  }))</pre> | `{}` | no |
| <a name="input_tagging_policies"></a> [tagging\_policies](#input\_tagging\_policies) | A map of tagging policies to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    # A description for the tagging policy<br/>    content = string<br/>    # The content of the tagging policy<br/>    key = optional(string)<br/>    # If we created the organizational unit, this is the key to attach the policy to<br/>    target_id = optional(string)<br/>    # If the organizational unit already exists, this is the target ID to attach the policy to<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_account_email"></a> [master\_account\_email](#output\_master\_account\_email) | The email address of the master account provided by AWS |
| <a name="output_master_account_id"></a> [master\_account\_id](#output\_master\_account\_id) | The ARN of the master account provided by AWS |
| <a name="output_organization_arn"></a> [organization\_arn](#output\_organization\_arn) | The ARN of the organization provided by AWS |
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | The ID of the organization provided by AWS |
| <a name="output_organizational_units"></a> [organizational\_units](#output\_organizational\_units) | The organizational units created in the organization |
<!-- END_TF_DOCS -->

```

```
