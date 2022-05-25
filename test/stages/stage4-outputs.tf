
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.cp-datavirtualization-svc.name
        inst_name   = module.cp-datavirtualization-svc.inst_name
        sub_chart   = module.cp-datavirtualization-svc.sub_chart
        sub_name   = module.cp-datavirtualization-svc.sub_name
        operator_namespace = module.cp-datavirtualization-svc.operator_namespace
        cpd_namespace= module.cp-datavirtualization-svc.cpd_namespace
        branch      = module.cp-datavirtualization-svc.branch
        namespace   = module.cp-datavirtualization-svc.namespace
        server_name = module.cp-datavirtualization-svc.server_name
        layer       = module.cp-datavirtualization-svc.layer
        layer_dir   = module.cp-datavirtualization-svc.layer == "infrastructure" ? "1-infrastructure" : (module.cp-datavirtualization-svc.layer == "services" ? "2-services" : "3-applications")
        type        = module.cp-datavirtualization-svc.type
      })
    }
  }
}
