#!/bin/sh
set -eu

TARGET_DIR="/usr/share/nginx/html"
PLACEHOLDER="__RUNTIME_API_BASE_URL__"

if [ -n "${API_BASE_URL:-}" ]; then
  escaped_url=$(printf '%s' "$API_BASE_URL" | sed 's/[\/&]/\\&/g')

  find "$TARGET_DIR" -type f \( -name '*.js' -o -name '*.html' -o -name '*.json' \) \
    -exec sed -i "s/${PLACEHOLDER}/${escaped_url}/g" {} +
fi

exec "$@"
