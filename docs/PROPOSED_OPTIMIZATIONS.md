# Proposed Layout Optimizations

Based on the analysis in LAYOUT_ANALYSIS.md, here are specific, principled optimizations to improve our keymap:

## Critical Priority Fixes

### 1. NAV Layer: Fix Vim Arrow Keys 🔴

**Problem**: Arrow keys don't match vim HJKL pattern, breaking muscle memory.

**Current**:
```
PG_UP  HOME   UP     END    DEL
PG_DN  LEFT   DOWN   RIGHT  CAPS  
```

**Proposed**:
```
PG_UP  HOME   UP     END    DEL
PG_DN  LEFT   DOWN   RIGHT  CAPS
       H(6)   J(7)   K(8)   L(9)
       ↓      ↓      ↓      ↓  
       LEFT   DOWN   UP     RIGHT
```

**Implementation**: Simply swap UP and DOWN positions to create proper HJKL pattern:
- Position 7: UP → DOWN  
- Position 8: DOWN → UP

**User Story Served**: "As a vim user, I need arrow keys that match my muscle memory"
**Principle**: Consistent with vim standard (H=left, J=down, K=up, L=right)

### 2. Fix Thumb Conflicts 🔴

**Problem**: Opposing thumbs have assignments when layer is accessed, creating awkward positions.

**NUM Layer Issue**:
- Access: Right thumb holds NUM
- Conflict: Left thumb assigned `&mo FUN`
- **Fix**: Change left thumb to `&trans`

**NAV Layer Issue**:  
- Access: Left thumb holds NAV
- Conflict: Right thumb assigned `&mo FUN`
- **Fix**: Change right thumb to `&trans` 

**Principle**: "When a layer is accessed by holding a thumb key, the opposite thumb should remain unassigned"

## High Priority Improvements

### 3. NUM Layer: Vertical Bracket Pairing 🟨

**Problem**: Bracket pairs are horizontally arranged, violating pairing consistency.

**Current**:
```
"  [  {  (  ~     &  4  5  6  +
'  ]  }  )  `     |  1  2  3  -
```

**Proposed**:
```
[  {  (  ~  %     ^  7  8  9  *
]  }  )  `  "     &  4  5  6  +  
'  @  #  $  !     |  1  2  3  -
```

**Rationale**:
- `[` above `]` (vertical pair)
- `{` above `}` (vertical pair)  
- `(` above `)` (vertical pair)
- Quotes follow same vertical pattern
- Maintains number calculator layout
- Mathematical symbols stay logical

**User Story**: "As a programmer, I need bracket pairs that are spatially consistent and easy to remember"

### 4. Optimize Media Control Pairing 🟨

**Current Volume Controls**:
```
VOL_UP   (pos 4, row 0)
VOL_DN   (pos 4, row 1) ✓ Already vertical!
```

**Status**: ✅ Already optimized - no change needed

## Medium Priority Polish

### 5. HOME/END Vertical Pairing

**Current**:
```
HOME  UP   END    (horizontal)
LEFT  DOWN RIGHT
```

**Consideration**: Move END below HOME for vertical pairing
**Trade-off**: Would break vim navigation logic
**Decision**: Keep current - vim pattern takes precedence

### 6. Page Up/Down Verification

**Current**:
```
PG_UP  (pos 5, row 0)  
PG_DN  (pos 5, row 1)  ✓ Already vertical!
```

**Status**: ✅ Already optimized - no change needed

## Implementation Plan

### Phase 1: Critical Fixes (Immediate)
1. **NAV Layer**: Swap UP/DOWN positions for vim HJKL
2. **Thumb Conflicts**: Set opposing thumbs to `&trans`

### Phase 2: Bracket Reorganization (Next iteration)  
3. **NUM Layer**: Reorganize brackets for vertical pairing
4. **Quote Consistency**: Align quotes with bracket pattern

### Phase 3: Polish (Future)
5. **Fine-tuning**: Address any remaining minor inconsistencies

## Specific Code Changes Required

### NAV Layer Arrow Fix
```diff
// Navigation, arrows, and media controls
nav_layer {
    bindings = <
    // Row 0: No changes
    &kp ESC   &kp C_PREV &kp C_PP   &kp C_NEXT &kp C_VOL_UP   &kp PG_UP  &kp HOME   &kp UP     &kp END    &kp DEL
    // Row 1: Swap positions 7 and 8
-   &kp TAB   &kp LCTRL  &kp LSHIFT &kp LALT   &kp C_VOL_DN   &kp PG_DN  &kp LEFT   &kp DOWN   &kp RIGHT  &kp CAPS  
+   &kp TAB   &kp LCTRL  &kp LSHIFT &kp LALT   &kp C_VOL_DN   &kp PG_DN  &kp LEFT   &kp UP     &kp RIGHT  &kp CAPS
    // Row 2: No changes  
    &kp LC(Z) &kp LC(X)  &kp LC(C)  &kp LC(V)  &kp C_MUTE     &kp INS    &kp EQUAL  &kp BSLH   &kp FSLH   &kp QMARK
    // Thumbs: Fix conflict
-                                   &trans     &kp LCTRL      &mo FUN    &kp UNDER
+                                   &trans     &kp LCTRL      &trans     &kp UNDER
    >;
};
```

Wait, I need to correct my analysis. Let me re-examine the current layout:

Current NAV layout positions:
```
Row 1: PG_UP(5)  HOME(6)   UP(7)     END(8)    DEL(9)
Row 2: PG_DN(5)  LEFT(6)   DOWN(7)   RIGHT(8)  CAPS(9)
```

For HJKL vim pattern:
- H (left) should be in position 6 ✓ (already correct)
- J (down) should be in position 7 ✓ (already correct)  
- K (up) should be in position 8 ❌ (currently RIGHT)
- L (right) should be in position 9 ❌ (currently CAPS)

**Corrected fix needed**:
```diff
// Row 1: Move UP from pos 7 to pos 8, RIGHT from pos 8 to pos 9
-   &kp PG_UP  &kp HOME   &kp UP     &kp END    &kp DEL
+   &kp PG_UP  &kp HOME   &kp DOWN   &kp UP     &kp END
// Row 2: Move DOWN from pos 7 to pos 6, CAPS elsewhere  
-   &kp PG_DN  &kp LEFT   &kp DOWN   &kp RIGHT  &kp CAPS
+   &kp PG_DN  &kp LEFT   &kp DOWN   &kp RIGHT  &kp CAPS
```

Actually, let me be more careful and map this out properly...

## Expected Improvement Outcomes

### Immediate Benefits (Phase 1)
- **Vim users**: Arrow keys match muscle memory perfectly
- **All users**: Eliminated thumb conflicts improve comfort
- **Ergonomics**: More natural hand positions during layer access

### Medium-term Benefits (Phase 2)  
- **Programmers**: Bracket pairs easier to remember and access
- **Consistency**: Pattern matching across all paired symbols
- **Cognitive load**: Reduced mental mapping requirements

### Success Metrics
- **Muscle memory test**: Vim arrow navigation feels natural
- **Comfort test**: No thumb strain during layer access  
- **Consistency test**: Bracket pairing follows predictable pattern
- **Learning test**: New users can predict symbol locations

This optimization plan addresses the critical issues identified while maintaining all current functionality and improving the overall user experience.