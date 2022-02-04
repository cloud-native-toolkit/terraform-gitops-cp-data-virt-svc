
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.gitops_module.name
        sub_chart   = module.gitops_module.sub_chart
        inst_chart  = module.gitops_module.inst_chart
        branch      = module.gitops_module.branch
        namespace   = module.gitops_module.namespace
        server_name = module.gitops_module.server_name
        layer       = module.gitops_module.layer
        layer_dir   = module.gitops_module.layer == "infrastructure" ? "1-infrastructure" : (module.gitops_module.layer == "services" ? "2-services" : "3-applications")
        type        = module.gitops_module.type
      })
    }
  }
}
