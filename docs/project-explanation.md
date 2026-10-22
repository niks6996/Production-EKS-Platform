# Project explanation
## The problem

Manual infrastructure and application setup can drift between environments. This project explores how to describe that setup in code, validate changes, package an application consistently and prepare security and operations controls before deployment.

## A short explanation

I built a production-style AWS EKS platform portfolio project using modular Terraform, Helm and GitHub Actions, with prepared Argo CD, monitoring and policy configuration. To validate the application without creating AWS resources or loading my laptop, I added a manual workflow that builds the container, deploys two replicas into a temporary Kind cluster, checks readiness and API endpoints, and deletes the cluster. That runtime test passed. The AWS architecture remains configured and validated, with live EKS deployment and platform integration testing still pending.

Adapt this explanation to your own understanding. Describe assistance honestly if asked. Do not present this project as paid employment or customer production operations.