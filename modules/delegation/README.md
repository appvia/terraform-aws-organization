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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_auditmanager_organization_admin_account_registration.audit_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/auditmanager_organization_admin_account_registration) | resource |
| [aws_detective_organization_admin_account.detective_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/detective_organization_admin_account) | resource |
| [aws_fms_admin_account.fms_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_admin_account) | resource |
| [aws_guardduty_organization_admin_account.guardduty_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_admin_account) | resource |
| [aws_iam_service_linked_role.access_analyzer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_inspector2_delegated_admin_account.inspection_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_delegated_admin_account) | resource |
| [aws_macie2_account.macie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/macie2_account) | resource |
| [aws_macie2_organization_admin_account.macie_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/macie2_organization_admin_account) | resource |
| [aws_organizations_delegated_administrator.access_analyzer_administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_delegated_administrator.delegated_administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_delegated_administrator.stacksets_administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_securityhub_organization_admin_account.securityhub_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_vpc_ipam_organization_admin_account.ipam_organization_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_organization_admin_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_delegation"></a> [enable\_delegation](#input\_enable\_delegation) | Provides at the capability to delegate the management of a service to another AWS account. | <pre>object({<br/>    access_analyzer = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Access Analyzer to<br/>    }), null)<br/>    audit_manager = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Audit Manager to<br/>    }), null)<br/>    detective = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Detective to<br/>    }), null)<br/>    firewall_manager = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Firewall Manager to<br/>    }), null)<br/>    guardduty = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of GuardDuty to<br/>    }), null)<br/>    inspector = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Inspector to<br/>    }), null)<br/>    ipam = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of IPAM to<br/>    }), null)<br/>    organizations = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Organizations to<br/>    }), null)<br/>    macie = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Macie to<br/>    }), null)<br/>    securityhub = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of Security Hub to<br/>    }), null)<br/>    stacksets = optional(object({<br/>      account_id = string<br/>      # The account id of the account to delegate the management of StackSets to<br/>    }), null)<br/>    config = optional(object({<br/>      account_id = string<br/>      # The id of the account to delegate the management of Config to<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "access_analyzer": null,<br/>  "audit_manager": null,<br/>  "config": null,<br/>  "detective": null,<br/>  "firewall_manager": null,<br/>  "guardduty": null,<br/>  "inspector": null,<br/>  "ipam": null,<br/>  "macie": null,<br/>  "organizations": null,<br/>  "securityhub": null,<br/>  "stacksets": null<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to resources provisioned by this module. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

```

```
