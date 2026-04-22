#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[2/4] Generating BDD test code..."
dart run build_runner build --delete-conflicting-outputs

echo "[3/4] Organizing generated BDD tests..."
while IFS= read -r feature_file; do
  feature_dir="$(dirname "$feature_file")"
  bdd_dir="$(dirname "$feature_dir")"
  generated_dir="$bdd_dir/generated"
  generated_source="${feature_file%.feature}_test.dart"

  if [[ -f "$generated_source" ]]; then
    mkdir -p "$generated_dir"
    generated_target="$generated_dir/$(basename "$generated_source")"

    sed "s|\./\.\./steps/|../steps/|g" "$generated_source" > "$generated_target"
    rm -f "$generated_source"
  fi
done < <(find integration_test -type f -name '*.feature' | sort)

echo "[4/4] Discovering integration test files..."
mapfile -t test_files < <(find integration_test -type f -name '*_test.dart' | sort)

if [[ ${#test_files[@]} -eq 0 ]]; then
  echo "No integration test files found under integration_test/."
  exit 0
fi

echo "[5/5] Running integration tests sequentially on Linux device..."
for test_file in "${test_files[@]}"; do
  echo "-> Running $test_file"
  flutter test "$test_file" -d linux
  echo ""
done

echo "All integration tests passed."
