# Debug Mode - Key Code Debugging Guide

## Overview
Both Test Mode (Testground.qml) and Learn Mode (ShortcutView.qml) now have comprehensive debug overlays that show real-time information about key presses, navigation state, and system behavior.

## How to Use Debug Mode

### Enable/Disable Debug Mode

**Default:** Debug mode is **ENABLED** by default (for development in Qt Creator)

**To Disable in Production:**
Set `debugMode: false` in the file:

```qml
// In Testground.qml or ShortcutView.qml
property bool debugMode: false  // Change true to false
```

**To Toggle at Runtime:**
Click the "Hide Debug" button at the bottom of the debug panel

## Debug Panel Information

### Display Location
- **Position:** Top-right corner of the window
- **Size:** 300×250 pixels
- **Color:** Semi-transparent black with green border
- **z-index:** 999 (always on top)

### Information Displayed

#### 1. **Last Key Pressed**
- Shows the human-readable name of the last key pressed
- Examples: "Space", "Esc", "Ctrl", "A", "F1", "Enter"

#### 2. **Key Code**
- Shows the Qt key code (integer value)
- Useful for debugging unrecognized keys
- Examples: 32 (Space), 16777216 (Esc), 65 (A)

#### 3. **Space Count**
- Shows how many times Space has been pressed in sequence
- Resets to 0 after 500ms of no Space presses
- Used for detecting double/triple space

#### 4. **Esc Pressed State**
- Shows "YES" (red) when Esc is held down
- Shows "NO" (gray) when Esc is released
- Used for detecting Esc+Space combo

#### 5. **Current Step / Total Steps**
- Shows progress through the current shortcut sequence
- Format: "3/4" means you've pressed 3 out of 4 keys
- Resets to 0 when sequence completes or on error

#### 6. **Expected Key**
- Shows which key the system is waiting for
- Format: The exact key name (e.g., "Ctrl", "S", "F5")
- Shows "N/A" when not waiting for a key

#### 7. **Question/Shortcut Counter**
- **Test Mode:** "Question: 5/20"
- **Learn Mode:** "Shortcut: 5/20"
- Shows current position in the question/shortcut list

#### 8. **Debug Info (Live Feed)**
- Real-time status messages showing what's happening
- Examples:
  - "Key pressed: A (Code: 65)"
  - "Double Space! Skipping forward..."
  - "ESC+SPACE detected! Exiting to Analysis..."
  - "Expected: Ctrl, Got: Ctrl → ✓"
  - "Sequence complete! CORRECT"

## Debug Messages Reference

### Navigation Messages

| Message | Meaning |
|---------|---------|
| "Space pressed! Count: 1, Esc: false" | First space press detected |
| "Space pressed! Count: 2, Esc: false" | Second space press (will trigger skip) |
| "Double Space! Skipping forward..." | Double space detected, moving to next |
| "Triple Space! Going back..." | Triple space detected, moving to previous |
| "Space count reset" | 500ms elapsed, space counter reset |

### Exit Messages

| Message | Meaning |
|---------|---------|
| "Esc pressed and held" | Esc key is being held down |
| "ESC+SPACE detected! Exiting to Analysis..." | (Test mode) Exiting to analysis |
| "ESC+SPACE detected! Exiting to Categories..." | (Learn mode) Exiting to categories |
| "Esc released" | Esc key was released |

### Key Matching Messages

| Message | Meaning |
|---------|---------|
| "Expected: Ctrl, Got: Ctrl → ✓" | Correct key pressed |
| "Expected: S, Got: A → ✗" | Wrong key pressed |
| "Sequence complete! CORRECT" | All keys in sequence were correct |
| "Sequence complete! WRONG" | At least one key was incorrect |

### Error/Reset Messages

| Message | Meaning |
|---------|---------|
| "Early release! Resetting sequence..." | Key released before completing sequence |
| "Unknown key released, resetting" | Unexpected key release, resetting |
| "[AUTO-REPEAT BLOCKED]" | Key held down (auto-repeat prevented) |
| "Space released (used for navigation)" | Space key released after navigation use |

## Common Issues and Solutions

### Issue 1: Space Not Skipping

**Check Debug Panel:**
- Space Count should increment to 2 for skip
- "Space count reset" appears after 500ms

**Solution:**
- Press Space twice quickly (within 500ms)
- Watch "Space Count" in debug panel
- If count doesn't increment, Space key may be part of the shortcut

### Issue 2: Esc+Space Not Exiting

**Check Debug Panel:**
- "Esc Pressed: YES" should appear when holding Esc
- After pressing Space while holding Esc: "ESC+SPACE detected!"

**Solution:**
1. Hold Esc (don't release)
2. While holding Esc, press Space
3. Watch for "Esc Pressed: YES" in debug
4. Should see "ESC+SPACE detected! Exiting to..."

### Issue 3: Wrong Keys Detected

**Check Debug Panel:**
- "Last Key:" shows what system receives
- "Key Code:" shows the numeric code
- "Expected: X, Got: Y" shows mismatch

**Solution:**
- Check if "Last Key" matches what you pressed
- Some keys have different names (e.g., "Enter" vs "Return")
- Check Key Code against Qt documentation

### Issue 4: Keys Not Being Blocked (IPC Issue)

**Check Debug Panel:**
- Every key should show "Key pressed: ..."
- System shortcuts (Alt+Tab, etc.) should not work

**Solution:**
- Ensure focus is on the window (click inside first)
- Check for "event.accepted = true" in source code
- Verify Keys.enabled: true in keyHandler Rectangle

## Key Code Reference

### Common Key Codes

| Key | Code | Name Shown |
|-----|------|------------|
| Space | 32 | "Space" |
| Esc | 16777216 | "Esc" |
| Enter | 16777220 | "Enter" |
| Tab | 16777217 | "Tab" |
| Backspace | 16777219 | "Backspace" |
| Delete | 16777223 | "Delete" |
| Left Arrow | 16777234 | "Left" |
| Right Arrow | 16777236 | "Right" |
| Up Arrow | 16777235 | "Up" |
| Down Arrow | 16777237 | "Down" |
| F1 | 16777264 | "F1" |
| F5 | 16777268 | "F5" |
| F12 | 16777275 | "F12" |
| A-Z | 65-90 | "A"-"Z" |
| 0-9 | 48-57 | "0"-"9" |
| Ctrl | 16777249 | "Ctrl" |
| Alt | 16777251 | "Alt" |
| Shift | 16777248 | "Shift" |

### Numpad Keys
- Detected via Qt.KeypadModifier flag
- Same codes as number keys but with modifier
- Debug will show the number (e.g., "5" from numpad)

## Timer Behavior

### Space Reset Timer
- **Interval:** 500ms
- **Trigger:** Restarts on each Space press
- **Action:** Resets `spaceCount` to 0
- **Debug Message:** "Space count reset"

**Logic:**
```javascript
Timer {
    id: spaceResetTimer
    interval: 500
    onTriggered: {
        spaceCount = 0
        debugInfo = "Space count reset"
    }
}

// On each Space press:
spaceResetTimer.restart()  // Reset the 500ms countdown
```

## Development Workflow

### Step 1: Enable Debug Mode
```qml
property bool debugMode: true
```

### Step 2: Run in Qt Creator
- Build and run the application
- Navigate to Test or Learn mode
- Debug panel appears in top-right

### Step 3: Test Navigation
1. Press Space → Watch "Space Count: 1"
2. Press Space again quickly → Should see "Double Space! Skipping forward..."
3. Hold Esc → Watch "Esc Pressed: YES"
4. Press Space while holding Esc → Should see "ESC+SPACE detected!"

### Step 4: Test Key Detection
1. Start a shortcut/question
2. Press keys
3. Watch "Expected vs Got" messages
4. Verify green/red feedback matches debug info

### Step 5: Check IPC Blocking
1. Try Alt+Tab (should NOT work)
2. Try Ctrl+C (should NOT work)
3. Try Ctrl+V (should NOT work)
4. All keys should show in debug panel but not reach OS

### Step 6: Report Issues
If issues found:
1. Note the "Debug Info" message
2. Note the "Key Code" value
3. Note what you expected vs what happened
4. Include debug panel screenshot

## Production Deployment

Before releasing:

1. **Disable Debug Mode:**
   ```qml
   property bool debugMode: false
   ```

2. **Test without debug panel** to ensure no performance issues

3. **Verify IPC blocking** still works with debug disabled

4. **Optional:** Add a secret key combo to re-enable debug:
   ```qml
   // Example: Ctrl+Shift+D to toggle
   if (event.modifiers & Qt.ControlModifier &&
       event.modifiers & Qt.ShiftModifier &&
       event.key === Qt.Key_D) {
       debugMode = !debugMode
   }
   ```

## File Locations

- **Test Mode Debug:** `/home/user/mouselessQt/utils/Testground.qml:849-946`
- **Learn Mode Debug:** `/home/user/mouselessQt/utils/ShortcutView.qml:574-672`
- **Space Reset Timer (Test):** `/home/user/mouselessQt/utils/Testground.qml:838-846`
- **Space Reset Timer (Learn):** `/home/user/mouselessQt/utils/ShortcutView.qml:564-572`

## Technical Notes

### Why Timer Instead of Date.now()?
- QML doesn't reliably support JavaScript `Date.now()`
- Qt Timer is more accurate and consistent
- Timer automatically handles thread safety

### Why 500ms Window?
- Fast enough for deliberate double/triple press
- Slow enough to avoid accidental triggers
- Standard timing for multi-click detection

### Why event.accepted = true?
- Prevents event propagation to OS
- Essential for IPC blocking
- Stops system shortcuts from activating

## Troubleshooting Checklist

- [ ] Debug panel visible in top-right?
- [ ] "Last Key" updates when pressing keys?
- [ ] "Space Count" increments when pressing Space?
- [ ] "Esc Pressed" shows YES when holding Esc?
- [ ] "Expected Key" shows correct key name?
- [ ] "Debug Info" updates with status messages?
- [ ] System shortcuts (Alt+Tab) blocked?
- [ ] Double Space triggers skip?
- [ ] Esc+Space triggers exit?

If any checkbox fails, check the specific section above for solutions.
