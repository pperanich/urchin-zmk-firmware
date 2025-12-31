# AGENTS.md

Context and instructions for AI coding agents working with this repository.

## Project Overview

ZMK firmware for the Urchin keyboard - a 34-key split keyboard (3×5 + 2 thumbs per side) with Nice!Nano v2 controllers and nice!view displays.

## Build Commands

```bash
# Full build (left, right, settings reset) - handles SDK download on first run
./build.sh

# Build single target manually
uv run west build -s zmk/app -d build/left -b nice_nano_v2 -- \
  -DSHIELD="urchin_left nice_view_adapter nice_view_gem" -DZMK_CONFIG="$PWD/config"

# Update ZMK modules after config/west.yml changes
uv run west update

# Generate keymap visualization SVGs
./draw.sh
```

## Architecture

### Key Files
- `config/urchin.keymap` - Main keymap definition with layers, behaviors, macros, combos
- `config/urchin.conf` - Kconfig settings (Bluetooth, display, power)
- `config/urchin.json` - Physical keyboard layout for keymap-drawer
- `config/west.yml` - West manifest defining ZMK modules and dependencies

### Keymap Structure (config/urchin.keymap)
The keymap uses ZMK's devicetree syntax with these sections:
- **Layer indices** (#define BASE/EXT/SYM/NUM/SET)
- **Key position labels** (LT0-LT4, RT0-RT4, etc. for combos/behaviors)
- **Combos** - Multi-key triggers (settings layer, leader key, programming symbols)
- **Behaviors** - Custom hold-tap definitions (home row mods, magic shift, smart-num)
- **Macros** - Multi-key sequences (arrow `=>`, unicode characters)
- **Keymap layers** - The actual key bindings per layer

### ZMK Modules (via config/west.yml)
Uses urob's ZMK modules for advanced features:
- `zmk-auto-layer` - Numword auto-layer (stays active while typing numbers)
- `zmk-leader-key` - Vim-style leader sequences (D+F combo)
- `zmk-adaptive-key` - Context-aware behaviors (magic shift)
- `zmk-unicode` - Unicode character support

### Firmware Output
After build, firmware files are in:
- `build/left/zephyr/zmk.uf2` - Left half
- `build/right/zephyr/zmk.uf2` - Right half
- `build/reset/zephyr/zmk.uf2` - Settings reset utility

## Flashing

1. Double-tap reset button on Nice!Nano to enter bootloader
2. Copy appropriate `.uf2` file to the mounted drive
3. Board auto-reboots with new firmware

## Clean Build

```bash
rm -rf build/ .west/
./build.sh
```
