
#
# To find the service quotas for the AWS services, you can use the AWS CLI:
# https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-service-quotas.html
#
# To find services https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-services.html
#
resource "aws_servicequotas_service_quota" "service_quotas" {
  for_each = local.service_quotas

  service_code = each.value.service_code
  quota_code   = each.value.quota_code
  value        = each.value.value
}
