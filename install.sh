#!/bin/bash
set -e
PLUGIN_FILE="$(cd "$(dirname "$0")" && pwd)/default_format.py"
DEVFLOW_CELLAR="$(brew --prefix)/Cellar/devflow"
if [ ! -d "$DEVFLOW_CELLAR" ]; then
  echo "ERROR: devflow not installed."
  exit 1
fi
PLUGIN_DIR="$(brew --prefix)/lib/devflow/plugins"
mkdir -p "$PLUGIN_DIR"
cp "$PLUGIN_FILE" "$PLUGIN_DIR/"
echo "Installed."
