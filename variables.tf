
variable "gitops_config" {
  type        = object({
    boostrap = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
    })
    infrastructure = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    services = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
    applications = object({
      argocd-config = object({
        project = string
        repo = string
        url = string
        path = string
      })
      payload = object({
        repo = string
        url = string
        path = string
      })
    })
  })
  description = "Config information regarding the gitops repo structure"
}

variable "git_credentials" {
  type = list(object({
    repo = string
    url = string
    username = string
    token = string
  }))
  description = "The credentials for the gitops repo(s)"
  sensitive   = true
}

variable "namespace" {
  type        = string
  description = "The namespace where the application should be deployed"
}

variable "kubeseal_cert" {
  type        = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default     = ""
}

variable "cluster_ingress_hostname" {
  type        = string
  description = "Ingress hostname of the IKS cluster."
  default     = ""
}

variable "server_name" {
  type        = string
  description = "The name of the server"
  default     = "default"
}

variable "common_services_namespace" {
  type        = string
  description = "Namespace for cpd commmon services"
  default = "ibm-common-services"
}


variable "operator_namespace" {
  type        = string
  description = "Namespace for cpd operators"
  default = "cpd-operators"
}

variable "cpd_namespace" {
  type        = string
  description = "CPD namespace"
  default = "gitops-cp4d-instance"
}

variable "operator_channel" {
  type        = string
  description = "operator channel"
  default     = "v1.7"
}

variable "instance_version" {
  type        = string
  description = "Instance version"
  default     = "1.7.8"
}

variable "license" {
  type        = string
  description = "License type"
  default     = "Enterprise"
}

variable "install_plan" {
  type        = string
  description = "install plan"
  default     = "Automatic"
}

variable "size" {
  type        = string
  description = "Size"
  default     = "small"
}

variable "sub_syncwave" {
  type        = string
  description = "Sync Wave"
  default     = "-5"
}

variable "inst_syncwave" {
  type        = string
  description = "Sync Wave"
  default     = "-3"
}