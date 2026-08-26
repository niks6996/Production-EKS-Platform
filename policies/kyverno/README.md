# Kyverno platform policies

The `platform-workload-security` ClusterPolicy enforces baseline controls for application Pods in the `platform` namespace.

## Enforced controls

- Pods must run as non-root.
- Containers cannot use privilege escalation or privileged mode.
- Containers must use a read-only root filesystem.
- All Linux capabilities must be dropped.
- CPU and memory requests and limits are mandatory.
- Explicit image tags are mandatory and the mutable `latest` tag is forbidden.

The platform API Helm chart is designed to comply with these controls. Kyverno reports policy decisions through Kubernetes admission events and policy reports.