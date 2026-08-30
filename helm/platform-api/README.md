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

## Development ingress

`values-dev.yaml` enables an internet-facing Application Load Balancer with IP
targets and `/health` target-group checks. The rule is intentionally hostless so
the generated ALB DNS name can be tested before a domain exists.

HTTPS will be enabled only after an ACM certificate and real DNS name are
available. At that point the certificate ARN, HTTPS listener and HTTP-to-HTTPS
redirect annotations must be added to the environment values.