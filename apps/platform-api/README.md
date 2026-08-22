# Platform API

The platform API is a dependency-free Python service used to demonstrate container delivery to Amazon EKS.

## Endpoints

| Endpoint | Purpose |
| --- | --- |
| `/` | Application name, version and status |
| `/health` | Container liveness check |
| `/ready` | Kubernetes readiness check |
| `/metrics` | Prometheus-format application metrics |

## Container controls

- Runs as UID and GID `10001`
- Uses a minimal Python slim image
- Contains no application package dependencies
- Includes a container health check
- Writes logs to standard output

The GitHub Actions workflow runs the unit tests and validates the container build without requiring Docker on the developer laptop.