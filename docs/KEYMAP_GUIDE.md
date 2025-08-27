# Optimized Urchin Keymap Guide

This keymap is designed for maximum efficiency and ergonomics, featuring home row modifiers, conditional layers, and comprehensive symbol coverage optimized for programming and general productivity.

## 🏗️ Architecture

### Layer Structure (6 layers total)
- **BASE** (0): QWERTY with home row mods - primary typing layer
- **WIN** (1): Windows variant with adjusted modifier order
- **NUM** (2): Numbers and comprehensive symbol coverage
- **NAV** (3): Navigation, arrows, media controls, and additional symbols
- **FUN** (4): Function keys and system controls
- **ADJ** (5): Advanced settings and Bluetooth management (conditional layer)

### Key Design Principles
1. **Home Row Modifiers**: All primary modifiers accessible without hand movement
2. **Conditional Layers**: Advanced features activate automatically when combining layers
3. **Symmetric Design**: Balanced placement for comfortable two-handed operation
4. **Strategic Combos**: Minimal combo usage for essential workflows
5. **OS Adaptation**: Dedicated Windows layer for cross-platform compatibility

## 🎯 Layer Details

### BASE Layer - Primary Typing
```
Q  W  E  R  T    Y  U  I  O  P
A  S  D  F  G    H  J  K  L  ⌫
Z  X  C  V  B    N  M  ,  .  ⏎
   NAV ⇧        ␣ NUM
```

**Home Row Modifiers** (Mac layout):
- `S`: Alt/Option
- `D`: Control
- `F`: Command/Super
- `J`: Command/Super
- `K`: Control  
- `L`: Alt/Option

**Thumb Cluster**:
- Left: `NAV + TAB` (layer-tap) and `SHIFT`
- Right: `SPACE` and `NUM + ESC` (layer-tap)

**Special Features**:
- Combo: `D + F` = Ctrl+Space (Adobe workflow)
- All letters and basic punctuation accessible

### WIN Layer - Windows Variant
Identical to BASE but with adjusted modifier order:
- `S`: Alt, `D`: Super, `F`: Control
- `J`: Control, `K`: Super, `L`: Alt

Toggle with `FUN layer → WIN_TOG`

### NUM Layer - Numbers & Symbols
```
!  @  #  $  %    ^  7  8  9  *
"  [  {  (  ~    &  4  5  6  +  
'  ]  }  )  `    |  1  2  3  -
   FUN —        0  —
```

**Optimized for**:
- Programming symbols on the left
- Numbers in calculator layout on the right
- Brackets and parentheses grouped logically
- Common operators easily accessible

### NAV Layer - Navigation & Media
```
ESC ⏮  ⏯  ⏭  🔊   ⇞ HOME ↑ END  DEL
TAB CTL SFT ALT 🔉   ⇟ ←   ↓  →  CAPS
↶  ✂  📋  📌  🔇   INS =  \  /   ?
    —  CTL      FUN _
```

**Features**:
- Media controls (left side)
- Arrow keys in vim-style cluster
- Copy/paste shortcuts
- Page navigation
- Additional symbols for programming

### FUN Layer - Function Keys & System
```
F1  F2  F3  F4  F5    F6  F7  F8  F9  F10
ALT GUI SFT CTL F11   F12 PRT SCR PAU WIN
RST —   —   —   —     —   🔅  🔆  —   RST
    —   —            —   —
```

**System Controls**:
- All function keys F1-F12
- Print Screen, Scroll Lock, Pause
- Brightness controls
- System reset
- Windows layer toggle

### ADJ Layer - Advanced Settings (Conditional)
Activates automatically when both NUM and NAV are held simultaneously.

```
BOOT —  —  BT_CLR BT0   BT3 OUT —  —  BOOT
—    —  —  —     BT1   BT4 —   —  —  —
—    —  —  —     BT2   BT5 —   —  —  —
     —  —              —   —
```

**Bluetooth Management**:
- BT0-BT5: Select Bluetooth profiles
- BT_CLR: Clear all Bluetooth bonds
- OUT: Toggle output (USB/Bluetooth)
- BOOT: Enter bootloader mode
- UNSTICK: Fix stuck modifiers

## ⚡ Special Features

### Smart Combos
- **Ctrl+Space**: Press `D + F` simultaneously (Adobe workflow)
- **ADJ Layer**: Press both outer thumb keys for quick settings access

### Conditional Layers
- **ADJ Layer**: Automatically activates when holding both NUM and NAV layers
- Provides seamless access to advanced features without dedicated key

### Home Row Mods
- **Tap**: Normal letter
- **Hold**: Modifier key
- Optimized timing prevents accidental activation
- Quick-tap feature for repeated letters

### OS Compatibility
- **Mac Layout**: Command on inner fingers (standard Mac workflow)
- **Windows Layout**: Control on inner fingers (standard Windows workflow)
- Easy switching via toggle in FUN layer

## 🚀 Advantages

### Ergonomic Benefits
1. **Reduced Hand Movement**: All modifiers on home row
2. **Balanced Load**: Symbols distributed across both hands
3. **Natural Thumb Usage**: Layer access via comfortable thumb keys
4. **Minimal Finger Stretching**: Frequently used keys in easy reach

### Productivity Features
1. **Comprehensive Coverage**: All symbols accessible without hunting
2. **Logical Grouping**: Related symbols placed together
3. **Quick Access**: Essential features via combos and conditional layers
4. **Workflow Optimization**: Adobe combo, copy/paste clusters

### Technical Excellence
1. **Modern ZMK Features**: Conditional layers, advanced hold-tap behavior
2. **Robust Configuration**: Stuck modifier fixes, bootloader access
3. **Flexible Bluetooth**: 6 device profiles with easy management
4. **Cross-Platform**: Dedicated Windows and Mac layouts

### Learning Curve
1. **Intuitive Layout**: Numbers in calculator arrangement
2. **Visual Logic**: Brackets grouped, arrows in vim-style cluster
3. **Gradual Adoption**: Can learn layers incrementally
4. **Familiar Patterns**: Standard QWERTY alpha layout preserved

## 🎯 Usage Tips

### Getting Started
1. Begin with BASE layer - standard QWERTY typing
2. Learn home row mods gradually (start with one hand)
3. Practice NUM layer for numbers and basic symbols
4. Add NAV layer for arrows and navigation
5. Explore FUN and ADJ layers for advanced features

### Optimization Strategies
1. **Home Row Priority**: Use home row mods instead of reaching for corner keys
2. **Layer Combinations**: Hold NUM+NAV for quick ADJ layer access
3. **Thumb Efficiency**: Use layer-taps for seamless layer switching
4. **Combo Integration**: Incorporate Ctrl+Space into Adobe workflows

### Troubleshooting
- **Stuck Modifiers**: Access unstick macro via ADJ layer
- **Wrong Characters**: Check if Windows layer is accidentally active
- **Bluetooth Issues**: Use BT_CLR in ADJ layer to reset connections

This keymap represents an optimal balance of functionality, ergonomics, and learnability for the modern typist and programmer.