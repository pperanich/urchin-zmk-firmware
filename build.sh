#!/bin/bash

set -e

echo "🔧 Building Urchin ZMK Firmware"
echo "================================"

# Check if uv is available and use it, otherwise fall back to system west
if command -v uv &> /dev/null; then
    WEST_CMD="uv run west"
    echo "Using west via uv"
elif command -v west &> /dev/null; then
    WEST_CMD="west"
    echo "Using system west"
elif [ -f "$HOME/.rye/tools/pip/bin/west" ]; then
    WEST_CMD="$HOME/.rye/tools/pip/bin/west"
    echo "Using west at: $WEST_CMD"
elif [ -f ~/Library/Python/*/bin/west ]; then
    WEST_CMD=$(find ~/Library/Python/*/bin/west 2>/dev/null | head -1)
    echo "Using west at: $WEST_CMD"
else
    echo "❌ Error: 'west' is not found. Please install dependencies with: uv sync"
    echo "   Or install manually with: pip install west"
    exit 1
fi

# Initialize workspace if not already done
if [ ! -d ".west" ]; then
    echo "📦 Initializing west workspace..."
    $WEST_CMD init -l config/
fi

echo "🔄 Updating dependencies..."
$WEST_CMD update

echo "🔧 Setting up Zephyr environment..."
# Export Zephyr CMake package
$WEST_CMD zephyr-export

# Skip manual package installation if using uv (packages are already in pyproject.toml)
if [[ "$WEST_CMD" != "uv run west" ]]; then
    if [ -f zephyr/scripts/requirements-base.txt ]; then
        echo "📦 Installing Zephyr base requirements..."
        pip install -r zephyr/scripts/requirements-base.txt
    fi

    if [ -f zephyr/scripts/requirements-extras.txt ]; then
        echo "📦 Installing Zephyr extra requirements (for ZMK Studio)..."
        pip install -r zephyr/scripts/requirements-extras.txt
    fi
else
    echo "📦 Using Python packages from pyproject.toml via uv"
fi

# Set Zephyr SDK environment variable
if [ -d "zephyr-sdk-0.16.8" ]; then
    export ZEPHYR_SDK_INSTALL_DIR="$PWD/zephyr-sdk-0.16.8"
fi

# Source Zephyr environment
if [ -f zephyr/zephyr-env.sh ]; then
    source zephyr/zephyr-env.sh
else
    echo "❌ Error: zephyr/zephyr-env.sh not found. Make sure west update completed successfully."
    exit 1
fi

# Create build directory
mkdir -p build

echo "🏗️  Building left half with nice!view..."
$WEST_CMD build -s zmk/app -d build/left -b nice_nano_v2 -- -DSHIELD="urchin_left nice_view_adapter nice_view_gem" -DZMK_CONFIG="$PWD/config"

echo "🏗️  Building right half with nice!view..."
$WEST_CMD build -s zmk/app -d build/right -b nice_nano_v2 -- -DSHIELD="urchin_right nice_view_adapter nice_view_gem" -DZMK_CONFIG="$PWD/config"

echo "🏗️  Building settings reset..."
$WEST_CMD build -s zmk/app -d build/reset -b nice_nano_v2 -- -DSHIELD="settings_reset" -DZMK_CONFIG="$PWD/config"

echo "✅ Build complete!"
echo ""
echo "📁 Firmware files:"
echo "   Left:  build/left/zephyr/zmk.uf2"
echo "   Right: build/right/zephyr/zmk.uf2"
echo "   Reset: build/reset/zephyr/zmk.uf2"