![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Organization Delegation Module

## Description

The purpose of this module is enable delegation of services away from the AWS management account into another accounts. Due to the fact many of these services are regional, the module has to be called for every region you want to delegate services to.

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
| <a name="input_enable_delegation"></a> [enable\_delegation](#input\_enable\_delegation) | Provides at the capability to delegate the management of a service to another AWS account. | <pre>object({<br/>    guardduty = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of GuardDuty to<br/>    }), null)<br/>    inspection = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Inspector to<br/>    }), null)<br/>    ipam = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of IPAM to<br/>    }), null)<br/>    organizations = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Organizations to<br/>    }), null)<br/>    macie = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Macie to<br/>    }), null)<br/>    securityhub = optional(object({<br/>      account_name = string<br/>      # The name of the account to delegate the management of Security Hub to<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "guardduty": null,<br/>  "inspection": null,<br/>  "ipam": null,<br/>  "macie": null,<br/>  "organizations": null,<br/>  "securityhub": null<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

```

```