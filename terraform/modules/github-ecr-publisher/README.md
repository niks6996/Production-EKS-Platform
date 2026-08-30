# GitHub ECR publisher

This module lets GitHub Actions publish container images to one ECR repository
using short-lived OIDC credentials. The trust policy accepts only the `main`
branch of the configured repository. No long-lived AWS access keys are needed.

After the infrastructure is deployed, store the `role_arn` output in the
repository variable `AWS_PUBLISH_ROLE_ARN`.