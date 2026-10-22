#!/usr/bin/env bash
set -euo pipefail
: "${IMAGE_TAG:?IMAGE_TAG must be set}"
[[ "$(kubectl config current-context)" == "kind-platform-ci" ]] || { echo 'Wrong cluster context'; exit 1; }
helm lint helm/platform-api --strict
helm upgrade --install platform-api helm/platform-api \
  --namespace platform --create-namespace \
  --set image.repository=local/platform-api \
  --set-string image.tag="$IMAGE_TAG" \
  --set image.pullPolicy=Never \
  --set fullnameOverride=platform-api \
  --set replicaCount=2 \
  --set ingress.enabled=false \
  --set autoscaling.enabled=false \
  --set serviceMonitor.enabled=false \
  --set networkPolicy.enabled=false \
  --set topologySpreadConstraints.enabled=false \
  --wait --timeout 180s
kubectl -n platform rollout status deployment/platform-api --timeout=180s
kubectl -n platform get deployment/platform-api -o json | python3 -c '
import json,sys
x=json.load(sys.stdin)
assert x["status"].get("readyReplicas")==2, x["status"]
print("PASS: both application replicas are ready")'
kubectl -n platform port-forward service/platform-api 18080:80 > /tmp/platform-port-forward.log 2>&1 &
forward_pid=$!
trap 'kill "$forward_pid" 2>/dev/null || true' EXIT
python3 - <<'PY'
import json, os, time
from urllib.request import urlopen
from urllib.error import HTTPError, URLError
base = 'http://127.0.0.1:18080'
for attempt in range(30):
    try:
        with urlopen(base+'/health', timeout=2) as r:
            assert json.load(r)=={'status':'healthy'}
        break
    except (URLError, TimeoutError):
        if attempt==29: raise
        time.sleep(1)
for path, expected in [('/health', {'status':'healthy'}),('/ready', {'status':'ready'})]:
    with urlopen(base+path, timeout=5) as r:
        assert r.status==200
        assert json.load(r)==expected
    print(f'PASS: {path} returned expected JSON')
with urlopen(base+'/', timeout=5) as r:
    data=json.load(r)
    assert data['application']=='platform-api'
    assert data['status']=='running'
    assert data['version']==os.environ['IMAGE_TAG']
print('PASS: root endpoint reports the tested commit')
with urlopen(base+'/metrics', timeout=5) as r:
    body=r.read().decode()
    assert 'platform_api_http_requests_total ' in body
    assert 'platform_api_uptime_seconds ' in body
    print(body)
print('PASS: metrics endpoint exposes application metrics')
try:
    urlopen(base+'/missing', timeout=5)
except HTTPError as e:
    assert e.code==404
else:
    raise AssertionError('Expected 404')
print('PASS: unknown endpoint returns 404')
PY