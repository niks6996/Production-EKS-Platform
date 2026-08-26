# Argo CD GitOps configuration

The `AppProject` limits deployments to this repository, the in-cluster Kubernetes API and the `platform` namespace.

The `Application` deploys the `helm/platform-api` chart and enables:

- automatic synchronisation
- configuration drift correction
- removal of resources deleted from Git
- namespace creation
- retry with exponential backoff
- server-side apply
- orphaned-resource warnings

The ECR account ID and image tag are placeholders. The delivery workflow will update the deployed image reference after AWS identity and ECR publishing are configured.

Argo CD itself will be installed only during the controlled live-cluster stage.