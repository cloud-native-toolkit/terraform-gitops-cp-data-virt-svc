
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.cp-data-virtualization-service.name
        inst_name   = module.cp-data-virtualization-service.inst_name
        sub_chart   = module.cp-data-virtualization-service.sub_chart
        sub_name   = module.cp-data-virtualization-service.sub_name
        operator_namespace = module.cp-data-virtualization-service.operator_namespace
        cpd_namespace= module.cp-data-virtualization-service.cpd_namespace
        branch      = module.cp-data-virtualization-service.branch
        namespace   = module.cp-data-virtualization-service.namespace
        server_name = module.cp-data-virtualization-service.server_name
        layer       = module.cp-data-virtualization-service.layer
        layer_dir   = module.cp-data-virtualization-service.layer == "infrastructure" ? "1-infrastructure" : (module.cp-data-virtualization-service.layer == "services" ? "2-services" : "3-applications")
        type        = module.cp-data-virtualization-service.type
      })
    }
  }
}
