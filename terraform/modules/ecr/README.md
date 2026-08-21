# ECR module

This module creates a secure Amazon ECR repository for the platform application image.

## Controls

- Immutable tags prevent an existing release tag from being overwritten.
- Scan-on-push checks newly pushed images for known vulnerabilities.
- AES-256 server-side encryption protects stored image layers.
- Lifecycle rules remove stale untagged images and limit retained releases.
- Terraform's default `force_delete = false` behaviour protects repositories containing images.