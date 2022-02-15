
output "name" {
  description = "The name of the module"
  value       = local.name
  depends_on  = [null_resource.setup_gitops_instance]
}

output "inst_name" {
  description = "The name of the module"
  value       = local.instance_content.name
  depends_on  = [null_resource.setup_gitops_instance]
}

output "sub_chart" {
  description = "The name of Subscription chart"
  value       = local.subscription_name
  depends_on  = [null_resource.setup_gitops_instance]
}

output "sub_name" {
  description = "The name of Subscription"
  value       = local.subscription_content.name
  depends_on  = [null_resource.setup_gitops_instance]
}

output "operator_namespace" {
  description = "Operator Namespace ibm-common-services"
  value       = var.operator_namespace
  depends_on  = [null_resource.setup_gitops_instance]
}

output "cpd_namespace" {
  description = "CPD Namespcae"
  value       = var.cpd_namespace
  depends_on  = [null_resource.setup_gitops_instance]
}

output "branch" {
  description = "The branch where the module config has been placed"
  value       = local.application_branch
  depends_on  = [null_resource.setup_gitops_instance]
}

output "namespace" {
  description = "The namespace where the module will be deployed"
  value       = local.namespace
  depends_on  = [null_resource.setup_gitops_instance]
}

output "server_name" {
  description = "The server where the module will be deployed"
  value       = var.server_name
  depends_on  = [null_resource.setup_gitops_instance]
}

output "layer" {
  description = "The layer where the module is deployed"
  value       = local.layer
  depends_on  = [null_resource.setup_gitops_instance]
}

output "type" {
  description = "The type of module where the module is deployed"
  value       = local.type
  depends_on  = [null_resource.setup_gitops_instance]
}


