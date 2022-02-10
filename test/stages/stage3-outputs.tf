
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.cp-watson-studio.name
        inst_name   = module.cp-watson-studio.inst_name
        sub_chart   = module.cp-watson-studio.sub_chart
        sub_name   = module.cp-watson-studio.sub_name
        operator_namespace = module.cp-watson-studio.operator_namespace
        branch      = module.cp-watson-studio.branch
        namespace   = module.cp-watson-studio.namespace
        server_name = module.cp-watson-studio.server_name
        layer       = module.cp-watson-studio.layer
        layer_dir   = module.cp-watson-studio.layer == "infrastructure" ? "1-infrastructure" : (module.cp-watson-studio.layer == "services" ? "2-services" : "3-applications")
        type        = module.cp-watson-studio.type
      })
    }
  }
}
