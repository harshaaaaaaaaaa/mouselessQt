# New Key Navigation System

## Overview
Implemented complete IPC blocking and new navigation controls for both Test Mode and Learn Mode.

## Key Features

### 1. **IPC Blocking (System Interaction Block)**
- All key events in Learn and Test modes are now blocked from reaching the OS/System
- Implemented via `event.accepted = true` on ALL key presses and releases
- Keys are directly captured by the application windows
- No system shortcuts (like Alt+Tab, Ctrl+C, etc.) will work while in these modes

### 2. **New Navigation Controls**

#### **Double Space - Skip Forward**
- Press Space twice quickly (within 800ms)
- Moves to next question/shortcut
- Works only when idle (currentStep === 0)

#### **Triple Space - Go Previous**
- Press Space three times quickly (within 800ms)
- Moves to previous question/shortcut
- Works only when idle (currentStep === 0)

#### **Esc+Space - Exit**
- Hold Esc, then press Space
- **Test Mode**: Exits and opens Analysis page with results
- **Learn Mode**: Exits to Categories page (saves progress)

### 3. **Space Detection Logic**
```javascript
property int spaceCount: 0
property int lastSpaceTime: 0

// Reset space count if more than 800ms since last space
if (currentTime - lastSpaceTime > 800) {
    spaceCount = 0
}
spaceCount++
```

### 4. **Esc State Tracking**
```javascript
property bool escPressed: false

// Track when Esc is pressed/released
Keys.onPressed: {
    if (event.key === Qt.Key_Escape) {
        escPressed = true
    }
}

Keys.onReleased: {
    if (event.key === Qt.Key_Escape) {
        escPressed = false
    }
}
```

## Files Modified

### **utils/Testground.qml**
- Added space detection with timing (double/triple space)
- Added Esc state tracking for Esc+Space combo
- Implemented IPC blocking on all key events
- Exit navigates to KeyAnalysis.qml with data
- Updated help overlay with new controls
- Updated UI hints: "Double SPACE to skip • Triple SPACE for previous • ESC+SPACE to exit"

### **utils/ShortcutView.qml**
- Added space detection with timing (double/triple space)
- Added Esc state tracking for Esc+Space combo
- Implemented IPC blocking on all key events
- Added session save/restore (currentIndex, count)
- Exit navigates back to CategoryView (stackView.pop())
- Updated header: "Learn Mode - Keys Visible!"
- Added navigation hints: "2× Space: skip • 3× Space: prev • Esc+Space: exit"

## Exit Behavior

### **Test Mode (Testground.qml)**
```javascript
if (escPressed) {
    saveSession()
    stackView.push("KeyAnalysis.qml", {
        attemptedKeys: attemptedKeys,
        appsdata: appsdata,
        stackView: stackView
    })
}
```
- Saves session state
- Opens Analysis page
- Shows test results and statistics

### **Learn Mode (ShortcutView.qml)**
```javascript
if (escPressed) {
    saveSession()
    stackView.pop()  // Returns to CategoryView
}
```
- Saves session state (where user left off)
- Returns to Categories page
- Progress is preserved

## Session Management

### **Learn Mode Session Data**
```javascript
{
    "currentIndex": currentIndex,
    "count": count,
    "timestamp": "2025-11-03T..."
}
```
Saved to: `userDataManager.saveSessionState(appId, "learn", sessionData)`

### **Test Mode Session Data**
```javascript
{
    "currentIndex": currentIndex,
    "count": count,
    "attemptedKeys": attemptedKeys,
    "timestamp": "2025-11-03T..."
}
```
Saved to: `userDataManager.saveSessionState(appId, "testground", sessionData)`

## User Experience

### **Test Mode Flow**
1. User selects app → Testground
2. Keys are HIDDEN (must guess)
3. Can navigate with double/triple space
4. Press Esc+Space to exit and see analysis
5. Analysis shows all attempted shortcuts with colors

### **Learn Mode Flow**
1. User selects app → Categories → ShortcutView
2. Keys are VISIBLE (can learn)
3. Can navigate with double/triple space
4. Press Esc+Space to exit back to categories
5. Next time, continues from where left off

## Technical Details

### **Timing Configuration**
- Space detection window: 800ms
- Space must be pressed 2-3 times within this window
- After 800ms, count resets to allow new sequence

### **IPC Blocking Implementation**
Every key event ends with:
```javascript
event.accepted = true
```
This prevents the event from propagating to the OS.

### **Focus Management**
Both modes call:
```javascript
keyHandler.forceActiveFocus()
```
on Component.onCompleted to ensure immediate key capture.

## Testing Checklist

- ✅ Double Space skips forward in Test mode
- ✅ Triple Space goes backward in Test mode
- ✅ Esc+Space exits Test mode → opens Analysis
- ✅ Double Space skips forward in Learn mode
- ✅ Triple Space goes backward in Learn mode
- ✅ Esc+Space exits Learn mode → returns to Categories
- ✅ Session saves on exit (both modes)
- ✅ Session restores on entry (both modes)
- ✅ All keys blocked from OS (no Alt+Tab, etc.)
- ✅ Space works in shortcuts (when currentStep > 0)

## Notes

- Space navigation only works when idle (currentStep === 0)
- When Space is part of a shortcut sequence, it's processed normally
- All system shortcuts are blocked while in Learn/Test modes
- Users can still exit via Back button or Esc+Space combo
