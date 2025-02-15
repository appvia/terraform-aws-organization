<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_quotas"></a> [service\_quotas](#input\_service\_quotas) | A collection of service quotas to apply to the organization. | <pre>list(object({<br/>    service_code = string<br/>    # The service code of the service quota<br/>    quota_code = string<br/>    # The quota code of the service quota<br/>    value = number<br/>    # The value of the service quota<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->