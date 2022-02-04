locals {
  name          = "cpd-data-virtualization"
  bin_dir       = module.setup_clis.bin_dir
  subscription_chart  = "ibm-cpd-dv-op-sub"
  instance_chart  = "ibm-cpd-dv-instance-cr"
  subscription_yaml_dir = "${path.cwd}/.tmp/${local.name}/chart/${local.subscription_chart}/"
  instance_yaml_dir     = "${path.cwd}/.tmp/${local.name}/chart/${local.instance_chart}/"
  ingress_host  = "${local.name}-${var.namespace}.${var.cluster_ingress_hostname}"
  ingress_url   = "https://${local.ingress_host}"
  service_url   = "http://${local.name}.${var.namespace}"
  values_content = {
    subscription = {
      name = "ibm-dv-operator-catalog-subscription"
      operator_namespace   = var.namespace
      spec = {
            channel = "v1.7"
            installPlanApproval = "Automatic"
            name = "ibm-dv-operator"
            source = "ibm-operator-catalog"
            sourceNamespace = "openshift-marketplace"
      }    
    }
    instance = {
      name = "dv-service"
      cpd_namespace = "cpd"
      spec = {
        license = {
          accept = "true"
          license = "Enterprise"
        }
        version = "1.7.5"
        size = "small"
      }               
    }
  }
  layer = "services"
  type = "operators"
  application_branch = "main"
  namespace = var.namespace
  layer_config = var.gitops_config[local.layer]
}

module setup_clis {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"
}

resource null_resource create_subcription_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-sub-yaml.sh '${local.subscription_chart}' '${local.subscription_yaml_dir}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content.subscription)
    }
  }
}

resource null_resource create_instance_yaml {
  depends_on = [null_resource.create_subcription_yaml]
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-instnace-yaml.sh '${local.instance_chart}' '${local.instance_yaml_dir}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content.instance)
    }
  }
}

resource null_resource setup_gitops_subscription {
  depends_on = [null_resource.create_subcription_yaml]

  triggers = {
    name = local.subscription_chart
    namespace = var.namespace
    yaml_dir = local.subscription_yaml_dir
    server_name = var.server_name
    layer = local.layer
    type = local.type
    git_credentials = yamlencode(var.git_credentials)
    gitops_config   = yamlencode(var.gitops_config)
    bin_dir = local.bin_dir
  }

  provisioner "local-exec" {
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --contentDir '${self.triggers.subscription_yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --delete --contentDir '${self.triggers.subscription_yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }
}

resource null_resource setup_gitops_instance {
  depends_on = [null_resource.create_instance_yaml, null_resource.setup_gitops_subscription]

  triggers = {
    name = local.instance_chart
    namespace = var.namespace
    yaml_dir = local.instance_yaml_dir
    server_name = var.server_name
    layer = local.layer
    type = local.type
    git_credentials = yamlencode(var.git_credentials)
    gitops_config   = yamlencode(var.gitops_config)
    bin_dir = local.bin_dir
  }

  provisioner "local-exec" {
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --contentDir '${self.triggers.instance_yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }

  provisioner "local-exec" {
    when = destroy
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --delete --contentDir '${self.triggers.instance_yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }
}
