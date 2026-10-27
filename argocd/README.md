# Argo CD GitOps configuration

This directory contains the AppProject and Applications used to deploy the
platform components to the EKS development cluster.

The AppProject permits the configured sources and destinations for the
`platform`, `monitoring`, `kyverno` and `kube-system` namespaces. It also
allows the cluster-scoped resources required by the platform components.

## Live deployment notes

The platform was deployed and tested on AWS EKS. The development environment
was destroyed after testing to control costs.

For a new deployment:

1. Install Argo CD and apply `project.yaml`.
2. Publish the application image to the newly created ECR repository.
3. Update the image repository and commit-SHA tag in `application.yaml`.
   The publishing workflow does not update this Application automatically.
4. Update the VPC ID in `aws-load-balancer-controller-application.yaml`
   using the current Terraform output. The VPC ID from a previous deployment
   will not work after that VPC has been destroyed.
5. Apply the platform Applications and verify their health.

The image tag and VPC ID currently in the Application files record values used
during a previous test. The associated ECR image and VPC were removed during
cleanup, so replace those values before redeployment.

## Kyverno comparison setting

The Kyverno Application includes an Argo CD comparison rule for empty CRD
metadata labels and annotations. The adjustment was added after the live
cluster returned those fields differently from the desired manifests. CRD
specifications remain subject to comparison.