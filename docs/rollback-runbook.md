# Remaining work

## Completed portfolio milestone

Repository configuration and validation cover infrastructure, application packaging, GitOps, monitoring, scanning, policies and operations. The manual application integration workflow passed on Kind. Screenshots were collected by the project owner. This is the current completion boundary.

## Before live AWS deployment

- Review the actual current AWS plan, service availability/pricing and account eligibility.
- Recheck Kubernetes support status and controller/chart compatibility for the deployment date.
- Review action references and replace mutable branches with reviewed commit pins.
- Replace account, identity, trusted-network, notification and image placeholders appropriately.
- Review OIDC trust, Pod Identity associations/agent, access entries, NAT routes and state protection.
- Inspect the Terraform plan and agree a deployment window and teardown procedure.

## Live verification still pending

Provisioning; ECR authentication/push; EKS node readiness; Argo CD bootstrap/sync; controller identity; ALB targets; application traffic; monitoring/alerts; Kyverno admission tests; HPA/node scaling; rollback/recovery drills; final teardown and residual-resource inspection.

## Portfolio maintenance

Add sanitised evidence and actual run URLs, keep claims aligned with results, practise the project explanation and update this status only after obtaining new evidence. A future production design would also need stronger availability, TLS, durable monitoring/logging, secrets lifecycle management and measured recovery objectives.