#!/bin/bash
set -e
PLUGIN_FILE="$(cd "$(dirname "$0")" && pwd)/default_format.py"
DEVFLOW_PREFIX="$(brew --prefix devflow 2>/dev/null)" || { echo "ERROR: devflow not installed."; exit 1; }
PLUGIN_LINK="$DEVFLOW_PREFIX/libexec/draft-pr/plugins"
# plugins may be a symlink whose target doesn't exist yet; resolve to the real path
if [ -L "$PLUGIN_LINK" ]; then
  LINK_PARENT="$(cd "$(dirname "$PLUGIN_LINK")" && pwd)"
  LINK_TARGET="$(readlink "$PLUGIN_LINK")"
  PLUGIN_DIR="$(python3 -c "import os,sys; print(os.path.normpath(os.path.join(sys.argv[1], sys.argv[2])))" "$LINK_PARENT" "$LINK_TARGET")"
else
  PLUGIN_DIR="$PLUGIN_LINK"
fi
mkdir -p "$PLUGIN_DIR"
cp "$PLUGIN_FILE" "$PLUGIN_DIR/"
echo "Installed."
