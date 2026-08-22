import json
import os
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from threading import Lock


APP_NAME = "platform-api"
APP_VERSION = os.getenv("APP_VERSION", "development")
START_TIME = time.monotonic()


class Metrics:
    def __init__(self):
        self._lock = Lock()
        self._requests = 0

    def increment_requests(self):
        with self._lock:
            self._requests += 1

    def render(self):
        with self._lock:
            requests = self._requests

        uptime = time.monotonic() - START_TIME
        return (
            "# HELP platform_api_http_requests_total Total HTTP requests received.\n"
            "# TYPE platform_api_http_requests_total counter\n"
            f"platform_api_http_requests_total {requests}\n"
            "# HELP platform_api_uptime_seconds Application uptime in seconds.\n"
            "# TYPE platform_api_uptime_seconds gauge\n"
            f"platform_api_uptime_seconds {uptime:.3f}\n"
        )


METRICS = Metrics()


class RequestHandler(BaseHTTPRequestHandler):
    server_version = APP_NAME
    sys_version = ""

    def do_GET(self):
        METRICS.increment_requests()

        routes = {
            "/": (200, "application/json", self._application_response()),
            "/health": (200, "application/json", '{"status":"healthy"}\n'),
            "/ready": (200, "application/json", '{"status":"ready"}\n'),
            "/metrics": (200, "text/plain; version=0.0.4", METRICS.render()),
        }

        status, content_type, body = routes.get(
            self.path,
            (404, "application/json", '{"error":"not found"}\n'),
        )
        encoded_body = body.encode("utf-8")

        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(encoded_body)))
        self.end_headers()
        self.wfile.write(encoded_body)

    def log_message(self, format, *args):
        print(json.dumps({
            "client": self.client_address[0],
            "message": format % args,
        }), flush=True)

    @staticmethod
    def _application_response():
        return (
            f'{{"application":"{APP_NAME}",'
            f'"version":"{APP_VERSION}",'
            '"status":"running"}\n'
        )


def create_server(host="0.0.0.0", port=8080):
    return ThreadingHTTPServer((host, port), RequestHandler)


if __name__ == "__main__":
    server_port = int(os.getenv("PORT", "8080"))
    server = create_server(port=server_port)
    print(f"{APP_NAME} listening on port {server_port}", flush=True)
    server.serve_forever()