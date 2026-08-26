# Platform monitoring

The monitoring stack uses the community `kube-prometheus-stack` Helm chart and is managed by Argo CD.

## Included capabilities

- Prometheus cluster and application metrics
- Grafana dashboards
- Alertmanager
- kube-state-metrics
- node exporter
- platform API availability, restart and CPU alerts
- a platform API Grafana dashboard

Development retention is limited to seven days and persistent volumes are disabled to avoid unnecessary storage costs. A production environment should use encrypted persistent storage and a defined backup policy.

## Grafana credentials

The real Grafana password must not be committed. Before live deployment, create the `grafana-admin-credentials` Secret through a secure secret-management process. `grafana-secret.example.yaml` documents the required keys and is not included in the Argo CD manifest path.