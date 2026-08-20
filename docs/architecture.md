# Platform architecture

## Design principles

1. Keep reusable infrastructure logic in Terraform modules.
2. Keep environment-specific values in environment root modules.
3. Use private subnets for EKS worker nodes.
4. Prefer short-lived workload identity over static AWS credentials.
5. Validate infrastructure and application changes before deployment.
6. Keep cluster workloads declarative and GitOps-managed.
7. Add observability, security and cost controls as platform capabilities.

## Planned request flow

1. A user sends an HTTP request to an AWS Application Load Balancer.
2. The AWS Load Balancer Controller maps Kubernetes Ingress configuration to the ALB.
3. The ALB routes the request to the application Service.
4. The Service sends traffic to healthy application Pods running on EKS nodes.
5. Prometheus collects platform and workload metrics for Grafana dashboards and alerts.

## Planned delivery flow

1. A developer pushes a change to GitHub.
2. GitHub Actions validates Terraform, Kubernetes and Helm files.
3. The application image is scanned and published to Amazon ECR.
4. Argo CD detects the desired-state change in Git.
5. Argo CD synchronises the approved manifests with the EKS cluster.

## Initial AWS network model

- One VPC
- Two Availability Zones
- Public subnets for internet-facing load balancers and NAT gateways
- Private subnets for EKS nodes
- Internet gateway for public-subnet routing
- NAT egress for workloads in private subnets

The exact NAT design will be selected before deployment because NAT gateways carry an hourly and data-processing cost.