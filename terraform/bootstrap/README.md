# Remote-state bootstrap

This configuration creates the S3 bucket used by the platform's Terraform backend.

## Security controls

- S3 Block Public Access enabled
- Bucket owner enforced
- Server-side encryption enabled
- Bucket versioning enabled for state recovery
- Bucket policy denies requests that do not use HTTPS
- Account-specific bucket name

Terraform's S3 backend lockfile will provide state locking when the development environment backend is configured. The bootstrap state remains local because it creates the remote backend itself.

## Important

Do not apply this configuration until the AWS deployment stage. The automated repository workflow performs `terraform init -backend=false` and `terraform validate`, so it does not create or modify AWS resources.