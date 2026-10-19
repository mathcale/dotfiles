#!/bin/bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${DIR}/external-skills.json"

if ! command -v npx &>/dev/null; then
  echo "npx not found, skipping external skills install."
  exit 0
fi

for source in $(jq -r '.sources | keys[]' "${CONFIG}"); do
  skills=()

  while IFS= read -r skill; do
    skills+=("${skill}")
  done < <(jq -r --arg s "${source}" '.sources[$s][]' "${CONFIG}")

  npx -y skills add "${source}" --global --yes --agent claude-code github-copilot --skill "${skills[@]}"

  echo "Skills from '${source}' installed."
done
