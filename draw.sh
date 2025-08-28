#!/bin/bash

set -e

echo "🎨 Drawing Urchin Keymap"
echo "========================"

# Check if uv is available and use it, otherwise fall back to system keymap
if command -v uv &>/dev/null; then
  KEYMAP_CMD="uv run keymap"
  echo "Using keymap-drawer via uv"
elif command -v keymap &>/dev/null; then
  KEYMAP_CMD="keymap"
  echo "Using system keymap-drawer"
else
  echo "❌ Error: 'keymap-drawer' is not found. Please install with: uv sync"
  echo "   Or install manually with: pip install keymap-drawer"
  exit 1
fi

# Clean up existing keymap files
echo "🧹 Cleaning up old keymap files..."
rm -f ./urchin_keymap*

# Parse the keymap
echo "📄 Parsing keymap..."
$KEYMAP_CMD -c keymap_drawer.config.yaml parse -z config/urchin.keymap -c 10 >urchin_keymap.yaml

# Draw the keymap
echo "🖼️  Drawing keymap SVG..."
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml >urchin_keymap.svg

# Draw individual layers for reference
echo "🖼️  Drawing individual layers..."
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml --select-layers BASE >urchin_keymap_base.svg
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml --select-layers EXT >urchin_keymap_ext.svg
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml --select-layers SYM >urchin_keymap_sym.svg
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml --select-layers NUM >urchin_keymap_num.svg
$KEYMAP_CMD -c keymap_drawer.config.yaml draw urchin_keymap.yaml --select-layers SET >urchin_keymap_set.svg

echo "✅ Keymap drawing complete!"
echo ""
echo "📁 Generated files:"
echo "   All layers:     urchin_keymap.svg"
echo "   Base layer:     urchin_keymap_base.svg"
echo "   Extend layer:   urchin_keymap_ext.svg"
echo "   Symbol layer:   urchin_keymap_sym.svg"
echo "   Number layer:   urchin_keymap_num.svg"
echo "   Settings layer: urchin_keymap_set.svg"
echo "   Parsed config:  urchin_keymap.yaml"

