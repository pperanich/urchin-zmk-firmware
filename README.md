# Urchin ZMK Firmware

ZMK firmware build environment for the [Urchin Keyboard](https://github.com/duckyb/urchin).

## Quick Start

### Prerequisites

- [uv](https://docs.astral.sh/uv/) (recommended) or Python 3.12+
- Homebrew (for macOS dependencies)

### Setup & Build

1. **Install system dependencies:**
   ```bash
   brew install dtc
   ```

2. **Install Python dependencies:**
   ```bash
   # With uv (recommended)
   uv sync
   
   # Or with pip
   pip install -r requirements.txt
   ```

3. **Build firmware:**
   ```bash
   ./build.sh
   ```

The build script will:
- Set up the ZMK/Zephyr build environment
- Download the Zephyr SDK (first run only)
- Build firmware for left half, right half, and settings reset

### Firmware Files

After building, you'll find the firmware files in:
- **Left half**: `build/left/zephyr/zmk.uf2`
- **Right half**: `build/right/zephyr/zmk.uf2`
- **Settings reset**: `build/reset/zephyr/zmk.uf2`

### Flashing

1. Put your Nice!Nano into bootloader mode (double-tap reset)
2. Copy the appropriate `.uf2` file to the mounted drive
3. The board will reboot with the new firmware

## Development

The build script automatically detects and uses `uv` if available, falling back to system Python packages otherwise.

### First-Time Setup

After cloning this repository, you need to fetch the ZMK modules:

```bash
# Initialize workspace
uv run west init -l config/

# Update dependencies (fetches urob's ZMK modules and ZMK itself)
uv run west update
```

### Using uv commands directly:

```bash
# Update dependencies after config changes
uv run west update

# Build specific target
uv run west build -s zmk/app -d build/left -b nice_nano_v2 -- -DSHIELD="urchin_left nice_view_adapter nice_view_gem" -DZMK_CONFIG="$PWD/config"

# Generate keymap visualization
uv run keymap -c keymap_drawer.config.yaml parse -z config/urchin.keymap -c 10 > urchin_keymap.yaml
uv run keymap -c keymap_drawer.config.yaml draw urchin_keymap.yaml > urchin_keymap.svg
```

## Project Structure

- `config/` - ZMK configuration files (keymap, config)
- `build.sh` - Main build script
- `pyproject.toml` - Python dependencies and project metadata
- `zephyr-sdk-0.16.8/` - Zephyr SDK (downloaded on first build)

## Keymap

The keymap is configured in `config/urchin.keymap`. This 34-key layout (3×5 + 2 thumbs per side) features advanced ZMK behaviors inspired by [urob's ZMK config](https://github.com/urob/zmk-config):

### Layers

- **BASE**: QWERTY with timeless home row mods (GASC layout)
- **EXT**: Navigation, media controls, and editing shortcuts (Undo/Cut/Copy/Paste/Redo)
- **SYM**: Programming symbols with combos for common operators
- **NUM**: Number row and function keys with auto-layer (numword) support
- **SETTINGS**: Bluetooth profiles, bootloader, and system reset

![Urchin Keymap](urchin_keymap.svg)

### Advanced Features

#### 🎯 Timeless Home Row Mods
Virtually misfire-free home row mods using urob's approach:
- **Long tapping-term** (280ms) makes behavior timing-insensitive
- **Positional hold-tap**: Mods only trigger when opposite hand is used
- **Balanced flavor**: Activates on nested keypresses
- **Hold-trigger-on-release**: Allows combining multiple mods on same hand

**Layout**: GASC (GUI, Alt, Shift, Ctrl)
- Left hand: `A`=GUI, `S`=Alt, `D`=Shift, `F`=Ctrl
- Right hand: `J`=Ctrl, `K`=Shift, `L`=Alt, `;`=GUI

#### ⚡ Magic Shift (Left Thumb)
Context-aware shift key with multiple functions:
- **Tap after letter** → Key repeat (e.g., "l" → "ll")
- **Tap after other key** → Sticky shift (capitalize next letter)
- **Hold** → Regular shift
- **Double-tap** → Caps-word mode (type `CONSTANT_NAMES` until space/punctuation)

#### 🔢 Numword (Smart-Num)
Auto-layer for seamless number entry (accessible from EXT or SYM layers):
- **Tap** → Numword activates, stays active while typing numbers
- **Auto-deactivates** → When any non-number key is pressed
- **Double-tap** → Sticky NUM layer
- **Hold** → Momentary NUM layer

**Example**: EXT → tap smart-num → type "2024" → press space → auto-deactivates

#### 🔑 Leader Key (D+F Combo)
Access hundreds of symbols and commands via sequences:

**System Commands**:
- `bl` → Bootloader mode
- `rst` → System reset
- `bc` → Bluetooth clear

**Programming Symbols**:
- `ar` → `=>` (arrow)
- `ne` → `!=` (not equal)
- `le` → `<=` (less than or equal)
- `ge` → `>=` (greater than or equal)

**Accented Characters**:
- `ea` → é (e acute)
- `eg` → è (e grave)
- `ec` → ê (e circumflex)
- `aa` → á (a acute)
- `ag` → à (a grave)
- `nt` → ñ (n tilde)
- `cc` → ç (c cedilla)

**Greek Letters** (prefix with `g`):
- `ga` → α (alpha)
- `gb` → β (beta)
- `gg` → γ (gamma)
- `gd` → δ (delta)
- `ge` → ε (epsilon)
- `gt` → θ (theta)
- `gl` → λ (lambda)
- `gm` → μ (mu)
- `gp` → π (pi)
- `gs` → σ (sigma)
- `go` → ω (omega)

**Usage**: Press D+F together, then type the sequence within 1 second.

#### 🎨 Additional Features
- **Mod-morphs**: `,` + Shift → `'`, `.` + Shift → `"`
- **Symbol combos**: `=>`, `<=`, `>=`, `!=` on SYM layer
- **One-shot modifiers**: Quick access to Ctrl/Shift/Alt/GUI on EXT layer

### ZMK Modules Used

This configuration uses the following [urob ZMK modules](https://github.com/urob):
- **zmk-helpers**: Simplified devicetree syntax
- **zmk-auto-layer**: Numword auto-layer functionality
- **zmk-leader-key**: Leader key sequences
- **zmk-adaptive-key**: Context-aware key behaviors (magic shift)
- **zmk-tri-state**: Advanced state management
- **zmk-unicode**: Unicode character support for accents and Greek letters

### Generate Keymap Visualization

You can regenerate the keymap visualization using:

```bash
./draw.sh
```

This will create:
- `urchin_keymap.svg` - All layers combined
- `urchin_keymap_base.svg` - Base layer only  
- `urchin_keymap_ext.svg` - Extension layer only
- `urchin_keymap_sym.svg` - Symbol layer only
- `urchin_keymap_num.svg` - Number layer only

## Troubleshooting

### Build Issues

- **Missing dtc**: Install with `brew install dtc`
- **Python package issues**: Try `uv sync --reinstall` or check Python version
- **West command not found**: Run `uv sync` to install dependencies

### Clean Build

```bash
rm -rf build/ .west/
./build.sh
```

This will reinitialize the entire build environment.

## Quick Reference

### Magic Shift Cheat Sheet
| Action | Result |
|--------|--------|
| Tap after letter (e.g., "l") | Repeat → "ll" |
| Tap after space/punctuation | Sticky shift (capitalize next) |
| Hold | Regular shift |
| Double-tap | Caps-word mode |

### Numword Access
- **From EXT layer**: Right thumb (tap for numword, hold for full NUM layer)
- **From SYM layer**: Left thumb (tap for numword, hold for full NUM layer)

### Leader Sequences
Press **D+F** together, then:

| Sequence | Output | Category |
|----------|--------|----------|
| `bl` | Bootloader | System |
| `rst` | Reset | System |
| `bc` | BT Clear | System |
| `ar` | `=>` | Symbol |
| `ne` | `!=` | Symbol |
| `le` | `<=` | Symbol |
| `ge` | `>=` | Symbol |
| `ea` | é | Accent |
| `eg` | è | Accent |
| `ec` | ê | Accent |
| `aa` | á | Accent |
| `ag` | à | Accent |
| `nt` | ñ | Accent |
| `cc` | ç | Accent |
| `ga` | α | Greek |
| `gb` | β | Greek |
| `gg` | γ | Greek |
| `gd` | δ | Greek |
| `ge` | ε | Greek |
| `gt` | θ | Greek |
| `gl` | λ | Greek |
| `gm` | μ | Greek |
| `gp` | π | Greek |
| `gs` | σ | Greek |
| `go` | ω | Greek |

## Credits

This configuration is heavily inspired by [urob's ZMK config](https://github.com/urob/zmk-config), implementing timeless home row mods, numword, magic shift, and leader key functionality using his excellent ZMK modules.