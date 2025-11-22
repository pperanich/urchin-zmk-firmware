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

# Download and set up Zephyr SDK if not present
SDK_VERSION="0.16.8"
SDK_DIR="zephyr-sdk-${SDK_VERSION}"

if [ ! -d "$SDK_DIR" ]; then
    echo "📦 Zephyr SDK not found, downloading..."

    # Detect platform
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    case "${OS}-${ARCH}" in
        linux-x86_64)
            SDK_FILE="zephyr-sdk-${SDK_VERSION}_linux-x86_64.tar.xz"
            ;;
        linux-aarch64)
            SDK_FILE="zephyr-sdk-${SDK_VERSION}_linux-aarch64.tar.xz"
            ;;
        darwin-x86_64)
            SDK_FILE="zephyr-sdk-${SDK_VERSION}_macos-x86_64.tar.xz"
            ;;
        darwin-arm64)
            SDK_FILE="zephyr-sdk-${SDK_VERSION}_macos-aarch64.tar.xz"
            ;;
        *)
            echo "❌ Unsupported platform: ${OS}-${ARCH}"
            echo "   Please manually download the Zephyr SDK from:"
            echo "   https://github.com/zephyrproject-rtos/sdk-ng/releases/tag/v${SDK_VERSION}"
            exit 1
            ;;
    esac

    SDK_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${SDK_VERSION}/${SDK_FILE}"

    echo "   Downloading ${SDK_FILE}..."
    if ! wget -q --show-progress "${SDK_URL}"; then
        echo "❌ Failed to download Zephyr SDK"
        exit 1
    fi

    echo "📦 Extracting SDK..."
    tar xf "${SDK_FILE}"

    echo "🔧 Running SDK setup..."
    cd "${SDK_DIR}"
    ./setup.sh -h -c
    cd ..

    echo "🧹 Cleaning up archive..."
    rm "${SDK_FILE}"

    echo "✅ Zephyr SDK ${SDK_VERSION} installed successfully"
else
    echo "✅ Zephyr SDK found at ${SDK_DIR}"
fi

# Set Zephyr SDK environment variable
export ZEPHYR_SDK_INSTALL_DIR="$PWD/${SDK_DIR}"

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