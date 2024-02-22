resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.2.3"  # Ensure this is the version you wish to use

  namespace = "argocd"
  create_namespace = true

  values = [
    file("./values.yaml")  # Optional: If you have specific configurations
  ]
}
