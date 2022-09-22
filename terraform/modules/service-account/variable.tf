variable "account_name" {
  description = "Name of the Service account to create"
}

variable "role_id" {
  description = "Role id of the custom role"
  default = "customrole"
}

variable "role_title" {
  description = "Role title of the custom role"
  default = "custom role"
}

variable "permission" {
  description = "List of permissions(IAM policies) to attach to custom role"
  type    = list
  default = []
}

variable "custom_role_required" {
  description = "If set to true, it will create"
  type   = bool
}

variable "rolesList" {
  description = "List of default roles(GCP Managed) to attach to the SA"
  type    = list(string)
  default = []
}

variable "namespace" {
  description = "namespace in k8s"
  default = "default"
}

variable "application_name" {
  description = "application name in helm"
  default = ""
}

variable "k8s_binding_required" {
  description = "If set to true, it will create"
  type   = bool
}