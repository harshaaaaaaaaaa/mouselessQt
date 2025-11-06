import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: root
    anchors.fill: parent

    required property var appsdata
    required property StackView stackView

    background: Rectangle {
        color: "#0a0a0a"
    }

    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []
    property int count: 1
    property var completedShortcuts: ({})  // Track completed shortcuts

    // New navigation state
    property bool escPressed: false
    property bool leftArrowHeld: false
    property bool rightArrowHeld: false

    // Debug mode properties
    property bool debugMode: true  // Set to false in production
    property string lastKeyPressed: ""
    property int lastKeyCode: 0
    property string debugInfo: ""

    Component.onCompleted: {
        loadSession()
        resetSequence()
        keyHandler.forceActiveFocus()
    }

    Component.onDestruction: {
        saveSession()
    }

    function loadSession() {
        if (userDataManager.currentUser !== "") {
            var session = userDataManager.loadSessionState(appsdata.id || "unknown", "learn")
            if (session && session.currentIndex !== undefined) {
                currentIndex = session.currentIndex || 0
                count = session.count || 1
            }
        }
    }

    function saveSession() {
        if (userDataManager.currentUser !== "") {
            var sessionData = {
                "currentIndex": currentIndex,
                "count": count,
                "timestamp": new Date().toISOString()
            }
            userDataManager.saveSessionState(appsdata.id || "unknown", "learn", sessionData)
        }
    }

    function resetSequence() {
        currentStep = 0
        activeKeys = {}
        keyColors = new Array(appsdata.shortcuts[currentIndex].keys.length).fill("white")
        expectedSequence = appsdata.shortcuts[currentIndex].keys
    }

    function keyEventToString(event) {
        var key = event.key

        // Number pad keys
        if (key >= Qt.Key_0 && key <= Qt.Key_9 && (event.modifiers & Qt.KeypadModifier)) {
            return String.fromCharCode('0'.charCodeAt(0) + (key - Qt.Key_0))
        }

        switch (key) {
        case Qt.Key_Control: return "Ctrl"
        case Qt.Key_Alt: return "Alt"
        case Qt.Key_Shift: return "Shift"
        case Qt.Key_Meta: return "Meta"
        case Qt.Key_Return: return "Enter"
        case Qt.Key_Space: return "Space"
        case Qt.Key_Tab: return "Tab"
        case Qt.Key_Backtab: return "Backtab"
        case Qt.Key_Backspace: return "Backspace"
        case Qt.Key_Delete: return "Delete"
        case Qt.Key_Insert: return "Insert"
        case Qt.Key_Home: return "Home"
        case Qt.Key_End: return "End"
        case Qt.Key_PageUp: return "PageUp"
        case Qt.Key_PageDown: return "PageDown"
        case Qt.Key_Up: return "up"
        case Qt.Key_Down: return "down"
        case Qt.Key_Left: return "left"
        case Qt.Key_Right: return "right"
        case Qt.Key_Escape: return "Esc"
        case Qt.Key_F1: return "F1"
        case Qt.Key_F2: return "F2"
        case Qt.Key_F3: return "F3"
        case Qt.Key_F4: return "F4"
        case Qt.Key_F5: return "F5"
        case Qt.Key_F6: return "F6"
        case Qt.Key_F7: return "F7"
        case Qt.Key_F8: return "F8"
        case Qt.Key_F9: return "F9"
        case Qt.Key_F10: return "F10"
        case Qt.Key_F11: return "F11"
        case Qt.Key_F12: return "F12"
        }

        if (key >= Qt.Key_A && key <= Qt.Key_Z) {
            return String.fromCharCode('A'.charCodeAt(0) + (key - Qt.Key_A))
        }
        if (key >= Qt.Key_0 && key <= Qt.Key_9) {
            return String.fromCharCode('0'.charCodeAt(0) + (key - Qt.Key_0))
        }

        return event.text !== "" && event.text !== '\x00' ? event.text : "Unknown"
    }

    function checkKeyPress(event) {
        const currentKey = expectedSequence[currentStep]
        let keyMatch = false

        // For modifier keys, check the actual key pressed, not the modifiers bitmask
        // This ensures "Ctrl+Shift+X" is different from "Shift+Ctrl+X"
        if (currentKey === "Ctrl") {
            keyMatch = (event.key === Qt.Key_Control)
        } else if (currentKey === "Shift") {
            keyMatch = (event.key === Qt.Key_Shift)
        } else if (currentKey === "Enter") {
            keyMatch = (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
        } else if (currentKey === "Alt") {
            keyMatch = (event.key === Qt.Key_Alt)
        } else if (currentKey === "PageDown") {
            keyMatch = event.key === Qt.Key_PageDown
        } else if (currentKey === "PageUp") {
            keyMatch = event.key === Qt.Key_PageUp
        } else if (currentKey === "Space") {
            keyMatch = event.key === Qt.Key_Space
        } else if (currentKey === "Tab") {
            keyMatch = event.key === Qt.Key_Tab
        } else if (currentKey === "Backtab") {
            keyMatch = event.key === Qt.Key_Backtab
        } else if (currentKey === "Backspace") {
            keyMatch = event.key === Qt.Key_Backspace
        } else if (currentKey === "Delete") {
            keyMatch = event.key === Qt.Key_Delete
        } else if (currentKey === "Insert") {
            keyMatch = event.key === Qt.Key_Insert
        } else if (currentKey === "Home") {
            keyMatch = event.key === Qt.Key_Home
        } else if (currentKey === "End") {
            keyMatch = event.key === Qt.Key_End
        } else if (currentKey === "up") {
            keyMatch = event.key === Qt.Key_Up
        } else if (currentKey === "down") {
            keyMatch = event.key === Qt.Key_Down
        } else if (currentKey === "left") {
            keyMatch = event.key === Qt.Key_Left
        } else if (currentKey === "right") {
            keyMatch = event.key === Qt.Key_Right
        } else if (currentKey === "Esc" || currentKey === "Escape") {
            keyMatch = event.key === Qt.Key_Escape
        } else if (currentKey === "F1") {
            keyMatch = event.key === Qt.Key_F1
        } else if (currentKey === "F2") {
            keyMatch = event.key === Qt.Key_F2
        } else if (currentKey === "F3") {
            keyMatch = event.key === Qt.Key_F3
        } else if (currentKey === "F4") {
            keyMatch = event.key === Qt.Key_F4
        } else if (currentKey === "F5") {
            keyMatch = event.key === Qt.Key_F5
        } else if (currentKey === "F6") {
            keyMatch = event.key === Qt.Key_F6
        } else if (currentKey === "F7") {
            keyMatch = event.key === Qt.Key_F7
        } else if (currentKey === "F8") {
            keyMatch = event.key === Qt.Key_F8
        } else if (currentKey === "F9") {
            keyMatch = event.key === Qt.Key_F9
        } else if (currentKey === "F10") {
            keyMatch = event.key === Qt.Key_F10
        } else if (currentKey === "F11") {
            keyMatch = event.key === Qt.Key_F11
        } else if (currentKey === "F12") {
            keyMatch = event.key === Qt.Key_F12
        } else {
            keyMatch = event.key === currentKey.charCodeAt(0)
        }

        return keyMatch && !activeKeys[currentKey]
    }

    function skipRight() {
        if (currentIndex < appsdata.shortcuts.length - 1) {
            currentIndex = currentIndex + 1
            count = count + 1
        }
        resetSequence()
    }

    function skipLeft() {
        if (currentIndex > 0) {
            currentIndex = currentIndex - 1
            count = count - 1
        }
        resetSequence()
    }

    function advanceShortcut() {
        // Check if all shortcuts have been completed at least once
        var allCompleted = true
        for (var i = 0; i < appsdata.shortcuts.length; i++) {
            if (!completedShortcuts[i]) {
                allCompleted = false
                break
            }
        }

        // If all completed, go back to CategoryView
        if (allCompleted) {
            saveSession()
            stackView.pop()  // Return to CategoryView
            return
        }

        // Otherwise, advance to next shortcut
        currentIndex = (currentIndex + 1) % appsdata.shortcuts.length
        count = (((count + 1) % (appsdata.shortcuts.length + 1)) == 0) ? 1 : count + 1
        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = success ? "✓ Correct!" : "✗ Try Again!"
        resultDisplay.color = success ? "#00ff00" : "#ff0000"
        resultDisplay.opacity = 1
        if (!success) errorResetTimer.restart()

        // Mark as completed if successful
        if (success) {
            var newCompleted = completedShortcuts
            newCompleted[currentIndex] = true
            completedShortcuts = newCompleted
        }

        // Record shortcut attempt with userDataManager
        if (userDataManager.currentUser !== "") {
            var shortcutId = appsdata.shortcuts[currentIndex].id || String(currentIndex)
            var categoryId = appsdata.id || "unknown"

            userDataManager.recordShortcutAttempt(
                appsdata.id || "unknown",
                categoryId,
                shortcutId,
                success,
                false  // isTestMode = false for learning mode
            )

            // Also save practice session (legacy)
            userDataManager.savePracticeSession(
                appsdata.id || "unknown",
                appsdata.title || "practice",
                appsdata.shortcuts[currentIndex].title,
                success
            )
        }
    }

    // Header
    Rectangle {
        id: headerBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Button {
                Layout.preferredHeight: 35
                Layout.preferredWidth: 80

                background: Rectangle {
                    color: parent.hovered ? "#1e1e1e" : "#151515"
                    radius: 6
                    border.color: "#333333"
                    border.width: 1
                }

                contentItem: Text {
                    text: "← Back"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: stackView.pop()
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "Learn Mode - Keys Visible!"
                font.pixelSize: 14
                font.bold: true
                color: "#6fda00"
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "Hold ← 2s: skip • Hold → 2s: prev • Esc+Space: exit"
                font.pixelSize: 10
                color: "#888888"
            }
        }
    }

    // Main content
    Rectangle {
        id: keyHandler
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"
        focus: true
        Keys.enabled: true

        Keys.onPressed: {
            // Update debug info
            lastKeyCode = event.key
            lastKeyPressed = keyEventToString(event)
            debugInfo = "Key pressed: " + lastKeyPressed + " (Code: " + lastKeyCode + ")"

            // Handle arrow key navigation FIRST (only when idle, before auto-repeat check)
            if (currentStep === 0) {
                // LEFT arrow - hold for 2 seconds to SKIP FORWARD
                if (event.key === Qt.Key_Left) {
                    if (!event.isAutoRepeat) {
                        leftArrowHeld = true
                        leftArrowTimer.restart()
                        debugInfo = "Left arrow pressed (hold 2s to skip forward)..."
                    } else {
                        debugInfo = "Left arrow held (timer running)..."
                    }
                    event.accepted = true
                    return
                }

                // RIGHT arrow - hold for 2 seconds to GO BACK
                if (event.key === Qt.Key_Right) {
                    if (!event.isAutoRepeat) {
                        rightArrowHeld = true
                        rightArrowTimer.restart()
                        debugInfo = "Right arrow pressed (hold 2s to go back)..."
                    } else {
                        debugInfo = "Right arrow held (timer running)..."
                    }
                    event.accepted = true
                    return
                }
            }

            if (event.isAutoRepeat) {
                event.accepted = true  // Block IPC
                debugInfo += " [AUTO-REPEAT BLOCKED]"
                return
            }

            // Track Esc key state
            if (event.key === Qt.Key_Escape) {
                escPressed = true
                debugInfo = "Esc pressed and held"
                event.accepted = true
                return
            }

            // Handle Space key for Esc+Space exit only
            if (event.key === Qt.Key_Space && escPressed) {
                // Esc+Space = Exit to Categories (save session)
                debugInfo = "ESC+SPACE detected! Exiting to Categories..."
                saveSession()
                stackView.pop()  // Go back to CategoryView
                event.accepted = true
                return
            }

            const currentKey = expectedSequence[currentStep]
            var newColors = keyColors.slice()
            var isCorrect = checkKeyPress(event)
            newColors[currentStep] = isCorrect ? "green" : "red"

            debugInfo = "Expected: " + currentKey + ", Got: " + lastKeyPressed + " → " + (isCorrect ? "✓" : "✗")

            keyColors = newColors
            activeKeys[currentKey] = true
            currentStep++

            if (currentStep === expectedSequence.length) {
                var isallkeys = keyColors.includes("red")
                if (!isallkeys) {
                    debugInfo = "Sequence complete! CORRECT"
                    showResult(true)
                    nextShortcutTimer.start()
                } else {
                    debugInfo = "Sequence complete! WRONG"
                    showResult(false)
                    resetTimer.start()
                }
            }

            // Block ALL keys from reaching OS (IPC block)
            event.accepted = true
        }

        Keys.onReleased: {
            debugInfo = "Key released: " + keyEventToString(event)

            // Reset Esc state
            if (event.key === Qt.Key_Escape) {
                escPressed = false
                debugInfo = "Esc released"
                event.accepted = true
                return
            }

            // Cancel arrow key navigation if released early
            if (event.key === Qt.Key_Left && leftArrowHeld) {
                leftArrowHeld = false
                leftArrowTimer.stop()
                debugInfo = "Left arrow released (cancelled navigation)"
                event.accepted = true
                return
            }

            if (event.key === Qt.Key_Right && rightArrowHeld) {
                rightArrowHeld = false
                rightArrowTimer.stop()
                debugInfo = "Right arrow released (cancelled navigation)"
                event.accepted = true
                return
            }

            const releasedKey = Object.keys(activeKeys).find(key =>
                (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
                (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
                (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
                (key === "Enter" && (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)) ||
                (event.key === key.charCodeAt(0)))

            if (!releasedKey && currentStep === expectedSequence.length) {
                delete activeKeys[releasedKey]
                debugInfo = "Key released after sequence complete"
            } else if (releasedKey) {
                delete activeKeys[releasedKey]
                if (currentStep > 0 && currentStep < expectedSequence.length) {
                    debugInfo = "Early release! Resetting sequence..."
                    resetSequence()
                }
            } else {
                delete activeKeys[releasedKey]
                resetSequence()
                debugInfo = "Unknown key released, resetting"
            }

            // Block ALL keys from reaching OS (IPC block)
            event.accepted = true
        }

        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.85
            spacing: 30

            // Progress counters
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                // Current position
                Rectangle {
                    width: 80
                    height: 40
                    color: "#151515"
                    radius: 20
                    border.color: "#333333"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: `${count}/${appsdata.shortcuts.length}`
                        font.pixelSize: 18
                        font.bold: true
                        color: "#6fda00"
                    }
                }

                // Completed count
                Rectangle {
                    width: completedText.width + 20
                    height: 40
                    color: "#1a4d1a"
                    radius: 20
                    border.color: "#00ff00"
                    border.width: 1

                    Text {
                        id: completedText
                        anchors.centerIn: parent
                        text: {
                            var completed = 0
                            for (var i = 0; i < appsdata.shortcuts.length; i++) {
                                if (completedShortcuts[i]) completed++
                            }
                            return "✓ " + completed + " done"
                        }
                        font.pixelSize: 14
                        font.bold: true
                        color: "#00ff00"
                    }
                }
            }

            // Title
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: appsdata.shortcuts[currentIndex].title
                font.pixelSize: 32
                font.bold: true
                color: completedShortcuts[currentIndex] ? "#666666" : "#ffffff"

                Rectangle {
                    visible: completedShortcuts[currentIndex]
                    anchors.left: parent.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 70
                    height: 28
                    radius: 14
                    color: "#1a4d1a"
                    border.color: "#00ff00"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "✓ Done"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#00ff00"
                    }
                }
            }

            // Keys row
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Repeater {
                    model: appsdata.shortcuts[currentIndex].keys

                    Rectangle {
                        width: 70
                        height: 50
                        radius: 8
                        color: keyColors[index] === "green" ? "#1a4d1a" :
                               keyColors[index] === "red" ? "#4d1a1a" : "#1a1a1a"
                        border.color: keyColors[index] === "green" ? "#00ff00" :
                                     keyColors[index] === "red" ? "#ff0000" : "#444444"
                        border.width: 2

                        scale: keyColors[index] !== "white" ? 1.05 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                        }
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                        Behavior on border.color {
                            ColorAnimation { duration: 150 }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 16
                            font.bold: true
                            color: keyColors[index] === "green" ? "#00ff00" :
                                   keyColors[index] === "red" ? "#ff0000" : "#888888"
                        }

                        Rectangle {
                            visible: keyColors[index] !== "white"
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: -5
                            width: 20
                            height: 20
                            radius: 10
                            color: keyColors[index] === "green" ? "#00ff00" : "#ff0000"

                            Text {
                                anchors.centerIn: parent
                                text: keyColors[index] === "green" ? "✓" : "✗"
                                font.pixelSize: 12
                                font.bold: true
                                color: "#000000"
                            }
                        }
                    }
                }
            }

            // Result
            Text {
                id: resultDisplay
                Layout.alignment: Qt.AlignHCenter
                text: ""
                font.pixelSize: 18
                font.bold: true
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }

    Timer {
        id: resetTimer
        interval: 1000
        onTriggered: {
            // Reset and stay on same shortcut (don't advance on wrong)
            currentStep = 0
            activeKeys = {}
            keyColors = new Array(appsdata.shortcuts[currentIndex].keys.length).fill("white")
            expectedSequence = appsdata.shortcuts[currentIndex].keys
            resultDisplay.opacity = 0
            keyHandler.forceActiveFocus()  // Restore focus
        }
    }

    Timer {
        id: nextShortcutTimer
        interval: 1500
        onTriggered: advanceShortcut()
    }

    Timer {
        id: errorResetTimer
        interval: 1000
        onTriggered: resultDisplay.opacity = 0
    }

    // Timer for left arrow hold (2 seconds) - LEFT = SKIP FORWARD
    Timer {
        id: leftArrowTimer
        interval: 2000
        onTriggered: {
            if (leftArrowHeld && currentStep === 0) {
                debugInfo = "Left arrow held 2s! Skipping forward..."
                skipRight()  // LEFT arrow skips forward
                leftArrowHeld = false
                keyHandler.forceActiveFocus()  // Restore focus after navigation
            }
        }
    }

    // Timer for right arrow hold (2 seconds) - RIGHT = GO BACK
    Timer {
        id: rightArrowTimer
        interval: 2000
        onTriggered: {
            if (rightArrowHeld && currentStep === 0) {
                debugInfo = "Right arrow held 2s! Going back..."
                skipLeft()  // RIGHT arrow goes back
                rightArrowHeld = false
                keyHandler.forceActiveFocus()  // Restore focus after navigation
            }
        }
    }

    // Debug overlay (only shown if debugMode is true)
    Rectangle {
        visible: debugMode
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        anchors.topMargin: 60
        width: 300
        height: 250
        color: "#dd000000"
        radius: 8
        border.color: "#00ff00"
        border.width: 2
        z: 999

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5

            Text {
                text: "🔧 DEBUG MODE (Learn)"
                font.pixelSize: 14
                font.bold: true
                color: "#00ff00"
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#333333" }

            Text {
                text: "Last Key: " + lastKeyPressed
                font.pixelSize: 11
                color: "#ffffff"
            }
            Text {
                text: "Key Code: " + lastKeyCode
                font.pixelSize: 11
                color: "#ffffff"
            }
            Text {
                text: "Left Arrow: " + (leftArrowHeld ? "HELD" : "Released")
                font.pixelSize: 11
                color: leftArrowHeld ? "#ffff00" : "#888888"
            }
            Text {
                text: "Right Arrow: " + (rightArrowHeld ? "HELD" : "Released")
                font.pixelSize: 11
                color: rightArrowHeld ? "#ffff00" : "#888888"
            }
            Text {
                text: "Esc Pressed: " + (escPressed ? "YES" : "NO")
                font.pixelSize: 11
                color: escPressed ? "#ff0000" : "#888888"
            }
            Text {
                text: "Current Step: " + currentStep + "/" + expectedSequence.length
                font.pixelSize: 11
                color: "#ffffff"
            }
            Text {
                text: "Expected Key: " + (currentStep < expectedSequence.length ? expectedSequence[currentStep] : "N/A")
                font.pixelSize: 11
                color: "#00ffff"
            }
            Text {
                text: "Shortcut: " + (currentIndex + 1) + "/" + appsdata.shortcuts.length
                font.pixelSize: 11
                color: "#ffffff"
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#333333" }

            Text {
                text: debugInfo
                font.pixelSize: 10
                color: "#888888"
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Item { Layout.fillHeight: true }

            Button {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 25

                background: Rectangle {
                    color: parent.hovered ? "#ff3333" : "#cc0000"
                    radius: 4
                }

                contentItem: Text {
                    text: "Hide Debug"
                    font.pixelSize: 10
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: debugMode = false
            }
        }
    }
}
