#!/usr/bin/env bash
set -euo pipefail

values_file="${1:-terraform/environments/dev/live.tfvars}"

for command in aws terraform kubectl helm; do
  command -v "${command}" >/dev/null || {
    echo "Missing required command: ${command}" >&2
    exit 1
  }
done

test -f "${values_file}" || {
  echo "Missing ${values_file}. Copy live.tfvars.example locally and replace its placeholders." >&2
  exit 1
}

if grep -q 'REPLACE_WITH_' "${values_file}"; then
  echo "Live values still contain placeholders." >&2
  exit 1
fi

grep -Eq '^enable_nat_gateway[[:space:]]*=[[:space:]]*true' "${values_file}" || {
  echo "Private-node deployment requires the controlled NAT Gateway setting." >&2
  exit 1
}

aws sts get-caller-identity >/dev/null
terraform -chdir=terraform/environments/dev fmt -check -recursive
terraform -chdir=terraform/environments/dev validate

echo "Live-deployment preflight passed. Review terraform plan before applying."