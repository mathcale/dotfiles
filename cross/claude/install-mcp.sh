#!/bin/bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${DIR}/mcp-servers.json"

if ! command -v claude &>/dev/null; then
  echo "claude CLI not found, skipping MCP server install."
  exit 0
fi

# Refuse to proceed if anything that looks like a literal secret slipped in: any env/header value that isn't a pure ${VAR} / ${VAR:-default} reference.
if jq -e '[.. | objects | (.env // {}, .headers // {}) | to_entries[]
          | select(.value | test("^\\$\\{[A-Za-z_][A-Za-z0-9_]*(:-[^}]*)?\\}$") | not)]
          | length > 0' "${CONFIG}" >/dev/null; then
  echo "${CONFIG} has env/header values that aren't \${VAR} references. Refusing to install."

  exit 1
fi

for name in $(jq -r '.mcpServers | keys[]' "${CONFIG}"); do
  claude mcp remove --scope user "${name}" &>/dev/null || true
  claude mcp add-json --scope user "${name}" "$(jq -c --arg n "${name}" '.mcpServers[$n]' "${CONFIG}")" >/dev/null

  echo "MCP server '${name}' installed."
done
