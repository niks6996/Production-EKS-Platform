# Automated security scanning

The security workflow provides three complementary checks.

## Repository scan

Trivy checks Terraform, Kubernetes, Helm and application files for high and critical vulnerabilities, misconfigurations and exposed secrets. Findings are uploaded to GitHub code scanning for review and remediation tracking.

## Secret detection gate

The workflow fails when Trivy detects a high or critical secret exposure in the checked-out repository files.

## Container vulnerability gate

The application image is built on the GitHub-hosted runner and scanned before publication. Fixable critical vulnerabilities fail the job. Unfixed upstream findings remain visible without making the delivery process impossible to complete.

The scheduled scan runs every Monday because new vulnerabilities can be published even when the repository code has not changed.