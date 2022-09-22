data "google_project" "project" {}

resource "google_service_account" "myaccount" {
  account_id    = var.account_name
}

#To create a custom IAM role and then to bind the custom IAM role to the service account created above. 
#This is if you do not want to use GCP managed roles as they have privileged access.
#set custom_role_required to true if you want to create your own role to attach to the SA.
resource "google_project_iam_custom_role" "test-custom-role" {
  count         = var.custom_role_required ? 1 : 0
  role_id       = var.role_id
  title         = var.role_title
  permissions   = var.permission
}

resource "google_project_iam_binding" "custom-role" {
    count       = var.custom_role_required ? 1 : 0
    project     = data.google_project.project.project_id
    role        = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.test-custom-role[count.index].role_id}"
     members    = [
         "serviceAccount:${google_service_account.myaccount.email}"
     ]
}
#To bind GCP Managed roles to service account above.
 resource "google_project_iam_binding" "default-role" {
    count       = length(var.rolesList)
    project     = data.google_project.project.project_id
    role        = var.rolesList[count.index]
     members    = [
         "serviceAccount:${google_service_account.myaccount.email}"
     ]
}
#Binding k8s SA to GCP SA using workload identity
resource "google_service_account_iam_member" "gce-default-account-iam" {
  count              = var.k8s_binding_required ? 1 : 0
  service_account_id = google_service_account.myaccount.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[${var.namespace}/${var.application_name}]" #serviceAccount:rsaf-puvss.svc.id.goog[default/puvss-ml-app]
}

