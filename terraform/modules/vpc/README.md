# VPC module

This reusable module creates the network foundation for the EKS platform.

## Included resources

- VPC with DNS support and DNS hostnames enabled
- Public and private subnets across at least two Availability Zones
- Internet gateway and public routing
- Separate private route tables
- Optional single NAT gateway for development workloads
- Kubernetes subnet discovery tags for public and internal load balancers

The development environment keeps the NAT gateway disabled by default because NAT gateways incur hourly and data-processing charges. It will be enabled only for a controlled live EKS deployment.