output "domain_name" {
  value = var.domain_name
}

output "subject_alternative_names" {
  value = var.subject_alternative_names
}

output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}