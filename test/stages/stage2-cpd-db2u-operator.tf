#module "gitops_db2u_operator" {  
#  source = "github.com/cloud-native-toolkit/terraform-gitops-db2u-operator"
#
#  gitops_config = module.gitops.gitops_config
#  git_credentials = module.gitops.git_credentials
#  server_name = module.gitops.server_name
#  operator_namespace = module.gitops_cp4d_operator.namespace
#  kubeseal_cert = module.gitops.sealed_secrets_cert
#}