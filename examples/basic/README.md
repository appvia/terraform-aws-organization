![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform <NAME>

## Description

Add a description of the module here

## Usage

Add example usage here

```hcl
module "example" {
  source  = "appvia/<NAME>/aws"
  version = "0.0.1"

  # insert variables here
}
```

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to resources provisioned by this module. | `map(string)` | n/a | yes |
| <a name="input_backup_policies"></a> [backup\_policies](#input\_backup\_policies) | A list of backup policies to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    filename    = string<br/>    key         = optional(string)<br/>    target_id   = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_aws_services"></a> [enable\_aws\_services](#input\_enable\_aws\_services) | The list of AWS services to enable in the organization. | `list(string)` | `[]` | no |
| <a name="input_enable_delegation"></a> [enable\_delegation](#input\_enable\_delegation) | Provides at the capability to delegate the management of a service to another AWS account. | <pre>object({<br/>    organizations = optional(object({<br/>      account_name = string<br/>    }), null)<br/>    securityhub = optional(object({<br/>      account_name = string<br/>    }), null)<br/>    guardduty = optional(object({<br/>      account_name = string<br/>    }), null)<br/>    ipam = optional(object({<br/>      account_name = string<br/>    }), null)<br/>    macie = optional(object({<br/>      account_name = string<br/>    }), null)<br/>    inspection = optional(object({<br/>      account_name = string<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "guardduty": null,<br/>  "inspection": null,<br/>  "ipam": null,<br/>  "macie": null,<br/>  "organizations": null,<br/>  "securityhub": null<br/>}</pre> | no |
| <a name="input_enable_policy_types"></a> [enable\_policy\_types](#input\_enable\_policy\_types) | The list of Organizations policy types to enable in the organization. | `list(string)` | <pre>[<br/>  "BACKUP_POLICY",<br/>  "SERVICE_CONTROL_POLICY",<br/>  "TAG_POLICY"<br/>]</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The organization with the tree of organizational units | <pre>object({<br/>    units = optional(list(object({<br/>      name = string,<br/>      key  = string,<br/>      units = optional(list(object({<br/>        name = string,<br/>        key  = string,<br/>        units = optional(list(object({<br/>          name = string,<br/>          key  = string,<br/>          units = optional(list(object({<br/>            name = string,<br/>            key  = string,<br/>            units = optional(list(object({<br/>              name = string,<br/>              key  = string,<br/>            })), [])<br/>          })), [])<br/>        })), [])<br/>      })), [])<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_service_control_policies"></a> [service\_control\_policies](#input\_service\_control\_policies) | A list of service control policies (SCPs) to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    filename    = string<br/>    key         = optional(string)<br/>    target_id   = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tagging_policies"></a> [tagging\_policies](#input\_tagging\_policies) | A list of tagging policies to apply to the organization's root. | <pre>map(object({<br/>    description = string<br/>    filename    = string<br/>    key         = optional(string)<br/>    target_id   = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
