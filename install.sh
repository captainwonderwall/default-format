#!/bin/bash
set -e
PLUGIN_FILE="$(cd "$(dirname "$0")" && pwd)/default_format.py"
DEVFLOW_PREFIX="$(brew --prefix devflow 2>/dev/null)" || { echo "ERROR: devflow not installed."; exit 1; }
PLUGIN_DIR="$DEVFLOW_PREFIX/libexec/draft-pr/plugins"
mkdir -p "$PLUGIN_DIR"
cp "$PLUGIN_FILE" "$PLUGIN_DIR/"
echo "Installed."
