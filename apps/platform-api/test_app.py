import json
import threading
import unittest
from urllib.error import HTTPError
from urllib.request import urlopen

from app import create_server


class ApplicationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.server = create_server(host="127.0.0.1", port=0)
        cls.port = cls.server.server_address[1]
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()

    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown()
        cls.server.server_close()
        cls.thread.join(timeout=2)

    def request(self, path):
        return urlopen(f"http://127.0.0.1:{self.port}{path}", timeout=2)

    def test_root_returns_application_information(self):
        with self.request("/") as response:
            payload = json.loads(response.read())
            self.assertEqual(response.status, 200)
            self.assertEqual(payload["application"], "platform-api")
            self.assertEqual(payload["status"], "running")

    def test_health_endpoint(self):
        with self.request("/health") as response:
            payload = json.loads(response.read())
            self.assertEqual(response.status, 200)
            self.assertEqual(payload, {"status": "healthy"})

    def test_readiness_endpoint(self):
        with self.request("/ready") as response:
            payload = json.loads(response.read())
            self.assertEqual(response.status, 200)
            self.assertEqual(payload, {"status": "ready"})

    def test_metrics_endpoint(self):
        with self.request("/metrics") as response:
            body = response.read().decode("utf-8")
            self.assertEqual(response.status, 200)
            self.assertIn("platform_api_http_requests_total", body)
            self.assertIn("platform_api_uptime_seconds", body)

    def test_unknown_endpoint_returns_404(self):
        with self.assertRaises(HTTPError) as error:
            self.request("/missing")
        self.assertEqual(error.exception.code, 404)


if __name__ == "__main__":
    unittest.main()