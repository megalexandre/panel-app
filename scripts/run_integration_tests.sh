#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/4] Starting WireMock..."
docker compose up -d wiremock

echo "[2/4] Generating BDD test code..."
dart run build_runner build --delete-conflicting-outputs

echo "[3/4] Discovering integration test files..."
mapfile -t test_files < <(find integration_test -type f -name '*_test.dart' | sort)

if [[ ${#test_files[@]} -eq 0 ]]; then
  echo "No integration test files found under integration_test/."
  exit 0
fi

echo "[4/4] Running integration tests sequentially on Linux device..."
for test_file in "${test_files[@]}"; do
  echo "-> Running $test_file"
  flutter test "$test_file" -d linux
  echo ""
done

echo "All integration tests passed."
