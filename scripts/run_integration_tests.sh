#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

TEST_FILE_FILTER="${TEST_FILE:-}"
TEST_NAME_FILTER="${TEST_NAME:-}"
VERBOSE_TEST_OUTPUT="${VERBOSE_TEST_OUTPUT:-0}"
AUTH_API_VERBOSE="${AUTH_API_VERBOSE:-0}"
START_PAUSED="${START_PAUSED:-0}"

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

if [[ -n "$TEST_FILE_FILTER" ]]; then
  filtered_files=()
  for test_file in "${test_files[@]}"; do
    if [[ "$test_file" == *"$TEST_FILE_FILTER"* ]]; then
      filtered_files+=("$test_file")
    fi
  done
  test_files=("${filtered_files[@]}")
fi

if [[ ${#test_files[@]} -eq 0 ]]; then
  if [[ -n "$TEST_FILE_FILTER" ]]; then
    echo "No integration test files matched TEST_FILE=$TEST_FILE_FILTER"
  else
    echo "No integration test files found under integration_test/."
  fi
  exit 0
fi

echo "[5/5] Running integration tests sequentially on Linux device..."
flutter_args=(-d linux)

if [[ "$AUTH_API_VERBOSE" == "1" ]]; then
  flutter_args+=(--dart-define=AUTH_API_VERBOSE=1)
fi

if [[ "$VERBOSE_TEST_OUTPUT" == "1" ]]; then
  flutter_args+=(--reporter expanded)
fi

if [[ "$START_PAUSED" == "1" ]]; then
  flutter_args+=(--start-paused)
fi

for test_file in "${test_files[@]}"; do
  echo "-> Running $test_file"
  if [[ -n "$TEST_NAME_FILTER" ]]; then
    flutter test "$test_file" "${flutter_args[@]}" --plain-name "$TEST_NAME_FILTER"
  else
    flutter test "$test_file" "${flutter_args[@]}"
  fi
  echo ""
done

echo "All integration tests passed."
