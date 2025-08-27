# Keymap Design Principles & User Stories

This document outlines the design philosophy, user stories, and principles that guide the optimization of our keymap layout. These principles serve as a knowledge base for future iterations and ensure consistency in design decisions.

## Core Design Philosophy

### Ergonomic Principles
1. **Minimize finger movement**: Frequently used keys should be on home row or adjacent
2. **Thumb efficiency**: Thumbs handle layer access, space, and modifiers primarily
3. **Hand balance**: Distribute cognitive and physical load across both hands
4. **Muscle memory consistency**: Similar functions should have consistent placement patterns

### Cognitive Load Principles
1. **Logical grouping**: Related functions should be spatially clustered
2. **Predictable patterns**: Similar key relationships should be maintained across layers
3. **Visual logic**: Key placement should follow intuitive spatial relationships
4. **Minimal layer depth**: Commonly used functions should be 1-2 layers deep maximum

## Layer-Specific User Stories & Principles

### BASE Layer - Primary Typing

**User Story**: "As a typist, I need to access all letters and basic punctuation with minimal finger movement, while having modifiers available without leaving home row."

**Design Principles**:
- QWERTY layout preserved for familiarity and muscle memory
- Home row modifiers (ASDF/JKL;) for ergonomic modifier access
- Thumb cluster optimized for layer access and space/enter
- Most frequent punctuation (comma, period) in accessible positions

**Current Implementation Analysis**:
✅ QWERTY preserved  
✅ Home row mods on S,D,F / J,K,L  
✅ Thumbs handle layers and primary input (space/enter)  
✅ Common punctuation accessible  

### NUM Layer - Numbers & Primary Symbols

**User Story**: "As a programmer/data entry user, I need quick access to all numbers and the most commonly used programming symbols, arranged in logical patterns that minimize cognitive load."

**Design Principles**:
- Numbers in familiar patterns (calculator layout or number row)
- Bracket pairs should be co-located (vertically preferred for thumb-reach)
- Quote pairs should follow same pattern as brackets
- Mathematical operators grouped logically
- Symmetrical symbol placement where possible

**Bracket/Quote Pairing Pattern**:
```
Opening → Closing (vertical pairs preferred)
[  →  ]
{  →  }
(  →  )
"  →  " (or separate keys)
'  →  '
```

**Current Implementation Analysis**:
✅ Numbers in calculator layout (7,8,9 / 4,5,6 / 1,2,3)  
❓ Bracket pairs: Need to verify vertical alignment  
❓ Quote placement: Check if quotes follow bracket pattern  
❓ Mathematical operators: Verify logical grouping  

### NAV Layer - Navigation & Media

**User Story**: "As someone who uses vim bindings and navigates documents frequently, I need arrow keys that match vim's HJKL pattern, with related navigation functions (page up/down, home/end) arranged in logical spatial relationships."

**Design Principles**:
- **Arrow keys must match vim pattern**: H(left), J(down), K(up), L(right)
- **Vertical pairs for related functions**:
  - Page Up ↕ Page Down
  - Home ↕ End  
  - Volume Up ↕ Volume Down
- **Media controls grouped together**
- **Editing functions (cut/copy/paste) in sequence**
- **Thumb access optimization**: If accessed via left thumb, right thumb should be free/unused

**Vim Navigation Mapping**:
```
H = ← (left)
J = ↓ (down)  
K = ↑ (up)
L = → (right)
```

**Vertical Pairing Examples**:
```
PgUp     VolUp     Home
PgDn  or VolDn  or End
```

**Current Implementation Analysis**:
❌ Arrow keys don't match HJKL pattern  
❓ Page Up/Down: Check if vertically aligned  
❓ Volume Up/Down: Check if vertically aligned  
❓ Thumb optimization: Verify right thumb isn't used when left accesses NAV  

### FUN Layer - Function Keys & System

**User Story**: "As a developer who uses function keys for debugging/IDE shortcuts and needs system controls, I want F-keys in order with system functions logically grouped nearby."

**Design Principles**:
- Function keys F1-F12 in sequential order
- System functions (reset, bluetooth) grouped away from accidental access
- Brightness controls should be paired vertically
- Print screen, caps lock in predictable positions
- Cross-platform toggles accessible but not prominent

**Current Implementation Analysis**:
✅ F1-F10 in sequence across top two rows  
✅ F11-F12 positioned logically  
❓ System controls: Check if safely positioned  
❓ Brightness: Verify vertical pairing  

### ADJ Layer - Advanced Settings (Conditional)

**User Story**: "As someone who manages multiple Bluetooth devices and needs system maintenance, I want these advanced functions safely tucked away but logically organized when I need them."

**Design Principles**:
- Bluetooth profiles in logical sequence (BT0, BT1, BT2...)
- Dangerous functions (bootloader, reset) in corners to prevent accidents
- Related functions paired (BT_CLR near BT profiles)
- Symmetrical layout for balance

**Current Implementation Analysis**:
✅ Conditional layer activation (safe access)  
❓ BT profiles: Check if in sequence  
❓ Dangerous functions: Verify corner placement  

## Universal Design Rules

### Thumb Key Access Rules
**Rule**: When a layer is accessed by holding a thumb key, the opposite thumb on the same split should remain unassigned or have minimal function to prevent conflicts.

**Application**:
- NAV layer (left thumb hold) → right thumb should be free
- NUM layer (right thumb hold) → left thumb should be free
- This prevents awkward hand positions and thumb conflicts

### Pairing Consistency Rules
**Rule**: Related key pairs should maintain consistent spatial relationships across all layers.

**Examples**:
- If opening/closing brackets are vertically paired in NUM layer, quotes should follow same pattern
- If volume up/down are vertically paired in NAV, brightness up/down should match
- Page up/down should follow same pattern as other paired functions

### Frequency-Based Placement
**Rule**: More frequently used functions should be easier to reach.

**Priority Order**:
1. Home row positions (easiest)
2. Adjacent to home row (one finger movement)
3. Top/bottom rows (greater stretch)
4. Pinky positions (weakest finger, use sparingly)

### Logical Grouping Rules
**Rule**: Functions should be grouped by purpose and context.

**Groups**:
- **Navigation**: Arrows, page/home/end, document navigation
- **Editing**: Cut, copy, paste, delete, insert
- **Media**: Play, pause, volume, brightness
- **System**: Bluetooth, reset, bootloader, output toggles
- **Symbols**: Mathematical, programming, punctuation

## Implementation Guidelines

### Layer Access Patterns
- **Single layer access**: Direct thumb holds for primary layers (NUM, NAV)
- **Conditional access**: Layer combinations for advanced features (ADJ)
- **Combo access**: Strategic combos for workflow-specific functions (Ctrl+Space)

### Testing Principles
When evaluating changes:
1. **Muscle memory test**: Do common patterns feel natural?
2. **Conflict test**: Are there thumb or finger conflicts?
3. **Logic test**: Do related functions group sensibly?
4. **Frequency test**: Are common functions easily accessible?
5. **Consistency test**: Do patterns match across layers?

## Future Iteration Framework

### Change Evaluation Process
1. **User story validation**: Does the change serve a clear user need?
2. **Principle compliance**: Does it follow our established design rules?
3. **Impact assessment**: What other functions are affected?
4. **Test against patterns**: Does it maintain logical consistency?
5. **Ergonomic review**: Does it improve or harm finger/hand comfort?

### Documentation Requirements
For each change:
- **Rationale**: Why is this change needed?
- **User story**: What user need does it serve?
- **Principle alignment**: Which design principles does it support?
- **Trade-offs**: What compromises are being made?
- **Success metrics**: How will we know if it works?

This framework ensures that all keymap modifications are thoughtful, consistent, and serve clear user needs while maintaining the overall design coherence.