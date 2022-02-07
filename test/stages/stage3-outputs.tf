
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.cp-data-virtualization.name
        sub_chart   = module.cp-data-virtualization.sub_chart
        inst_chart  = module.cp-data-virtualization.inst_chart
        branch      = module.cp-data-virtualization.branch
        namespace   = module.cp-data-virtualization.namespace
        server_name = module.cp-data-virtualization.server_name
        layer       = module.cp-data-virtualization.layer
        layer_dir   = module.cp-data-virtualization.layer == "infrastructure" ? "1-infrastructure" : (module.cp-data-virtualization.layer == "services" ? "2-services" : "3-applications")
        type        = module.cp-data-virtualization.type
      })
    }
  }
}
