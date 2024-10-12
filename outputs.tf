
output "organization_id" {
  description = "The ID of the organization provided by AWS"
  value       = aws_organizations_organization.organization.id
}

output "organization_arn" {
  description = "The ARN of the organization provided by AWS"
  value       = aws_organizations_organization.organization.arn
}

output "master_account_arn" {
  description = "The ARN of the master account provided by AWS"
  value       = aws_organizations_organization.organization.master_account_arn
}

output "master_account_email" {
  description = "The email address of the master account provided by AWS"
  value       = aws_organizations_organization.organization.master_account_email
}

output "master_account_name" {
  description = "The name of the master account provided by AWS"
  value       = aws_organizations_organization.organization.master_account_name
}

output "organizational_units" {
  description = "The organizational units created in the organization"
  value       = local.all_ou_attributes
}
