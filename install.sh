#!/bin/bash
# Development convenience install — for Homebrew distribution use Formula/ instead.
set -euo pipefail
PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
devflow-plugin register "default-format" "$PLUGIN_DIR/default_format.py"
echo "Installed default-format."
