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
| <a name="input_enable_policy_types"></a> [enable\_policy\_types](#input\_enable\_policy\_types) | A list of policy types to enable for the organization. | `list(string)` | <pre>[<br/>  "AISERVICES_OPT_OUT_POLICY",<br/>  "BACKUP_POLICY",<br/>  "SERVICE_CONTROL_POLICY",<br/>  "TAG_POLICY"<br/>]</pre> | no |
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
| <a name="output_organizational_units_map"></a> [organizational\_units\_map](#output\_organizational\_units\_map) | The organizational units created in the organization as a map |
<!-- END_TF_DOCS -->
