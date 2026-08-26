#!/usr/bin/env python3
import sys
from pathlib import Path

import yaml


def validate_file(path):
    documents = list(yaml.safe_load_all(path.read_text(encoding="utf-8")))
    if not documents:
        raise ValueError("contains no YAML documents")

    for index, document in enumerate(documents, start=1):
        if not isinstance(document, dict):
            raise ValueError(f"document {index} is not a YAML mapping")

        missing = [
            field
            for field in ("apiVersion", "kind", "metadata")
            if field not in document
        ]
        if missing:
            raise ValueError(
                f"document {index} is missing: {', '.join(missing)}"
            )

        metadata = document["metadata"]
        if not isinstance(metadata, dict) or not metadata.get("name"):
            raise ValueError(f"document {index} has no metadata.name")


def main():
    paths = sorted(Path("argocd").glob("*.yaml"))
    if not paths:
        print("No Argo CD YAML files found", file=sys.stderr)
        return 1

    failed = False
    for path in paths:
        try:
            validate_file(path)
            print(f"Valid: {path}")
        except (OSError, ValueError, yaml.YAMLError) as error:
            failed = True
            print(f"Invalid: {path}: {error}", file=sys.stderr)

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())