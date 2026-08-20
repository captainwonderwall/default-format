#!/bin/bash
set -e
PLUGIN_FILE="$(brew --prefix)/lib/devflow/plugins/default_format.py"
[ -f "$PLUGIN_FILE" ] || { echo "Not installed."; exit 0; }
rm "$PLUGIN_FILE"
echo "Removed."
