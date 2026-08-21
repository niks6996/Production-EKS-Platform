# Development environment

This root module composes reusable platform modules for the development environment.

## Current components

- VPC spanning two Availability Zones
- Two public subnets for internet-facing load balancers
- Two private subnets for EKS worker nodes
- Optional single NAT gateway for cost-controlled development deployments
- S3 backend configuration with native lockfile support
- ECR repository with immutable tags, scanning, encryption and retention controls

The example backend bucket name contains a placeholder AWS account ID. Replace it with the bootstrap output only during the controlled AWS deployment stage.