# Platform API Helm chart

This chart packages the platform API for deployment to Kubernetes and Amazon EKS.

## Default controls

- Two replicas
- Rolling updates with zero planned unavailability
- Liveness and readiness probes
- CPU and memory requests and limits
- Non-root execution with all Linux capabilities removed
- Read-only root filesystem
- Service account token automount disabled
- Pod disruption budget
- Network policy
- Topology spreading across Availability Zones
- Optional HPA, Ingress and ServiceMonitor resources

The image repository and tag in `values.yaml` are placeholders. The delivery pipeline will supply the deployed ECR image reference.