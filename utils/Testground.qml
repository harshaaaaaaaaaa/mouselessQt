import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: root
    anchors.fill: parent

    required property var appsdata
    required property StackView stackView
    property string mode: "test"  // "training" or "test"

    background: Rectangle {
        color: mode === "training" ? "#0a0a1a" : "#0a0a0a"  // Slight blue tint for training
    }

    // State management
    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []
    property var keyText: []
    property int count: 1
    property bool showHelp: false

    // New navigation state
    property bool escPressed: false
    property var lastLeftTapTime: 0
    property var lastRightTapTime: 0
    property int doubleTapThreshold: 300  // milliseconds

    // Debug mode properties
    property bool debugMode: true  // Set to false in production
    property string lastKeyPressed: ""
    property int lastKeyCode: 0
    property string debugInfo: ""

    property var attemptedKeys: Array.from(
        {"length": appsdata.test.length},
        () => ({"keypressed":[], "color":[],"attempt": false,"correct": false})
    )

    // Session management
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
            var session = userDataManager.loadSessionState(appsdata.id || "unknown", "testground")
            if (session && session.currentIndex !== undefined) {
                currentIndex = session.currentIndex || 0
                count = session.count || 1
                if (session.attemptedKeys) {
                    for (var i = 0; i < session.attemptedKeys.length && i < attemptedKeys.length; i++) {
                        attemptedKeys[i] = session.attemptedKeys[i]
                    }
                }
            }
        }
    }

    function saveSession() {
        if (userDataManager.currentUser !== "") {
            var sessionData = {
                "currentIndex": currentIndex,
                "count": count,
                "attemptedKeys": attemptedKeys,
                "timestamp": new Date().toISOString()
            }
            userDataManager.saveSessionState(appsdata.id || "unknown", "testground", sessionData)
        }
    }

    function resetSequence() {
        currentStep = 0
        activeKeys = {}
        expectedSequence = appsdata.test[currentIndex].keys
        keyColors = new Array(expectedSequence.length).fill("white")
        keyText = new Array(expectedSequence.length).fill("")
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
            keyMatch = event.key === Qt.Key_Space && currentStep > 0  // Only match Space if not idle
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
        if (currentIndex < appsdata.test.length - 1) {
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
        currentIndex = (currentIndex + 1) % appsdata.test.length
        count = (((count + 1) % (appsdata.test.length + 1)) == 0) ? 1 : count + 1
        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = "Submitted!"
        resultDisplay.opacity = 1
    }

    // Clean header bar
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

            // Back button
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

                onClicked: {
                    saveSession()
                    stackView.pop()
                }
            }

            Item { Layout.fillWidth: true }

            // Mode Indicator
            Rectangle {
                Layout.preferredHeight: 30
                Layout.preferredWidth: childText.width + 24
                radius: 15
                color: mode === "training" ? "#3377ee" : "#6fda00"
                border.color: mode === "training" ? "#5599ff" : "#7feb10"
                border.width: 2

                Text {
                    id: childText
                    anchors.centerIn: parent
                    text: mode === "training" ? "📚 TRAINING MODE" : "✓ TEST MODE"
                    font.pixelSize: 12
                    font.bold: true
                    color: mode === "training" ? "#ffffff" : "#000000"
                }
            }

            Text {
                text: mode === "training" ? "Practice freely - mistakes are okay!" : "Strict mode - prove your skills!"
                font.pixelSize: 11
                color: mode === "training" ? "#aaccff" : "#ff8800"
            }

            // Help button
            Button {
                Layout.preferredHeight: 35
                Layout.preferredWidth: 35

                background: Rectangle {
                    color: parent.hovered ? "#6fda00" : "#151515"
                    radius: 17.5
                    border.color: "#6fda00"
                    border.width: 2
                }

                contentItem: Text {
                    text: "?"
                    font.pixelSize: 18
                    font.bold: true
                    color: parent.parent.hovered ? "#000000" : "#6fda00"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: showHelp = !showHelp
            }
        }
    }

    // Main content area
    Rectangle {
        id: keyHandler
        anchors.top: headerBar.bottom
        anchors.bottom: bottomBar.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 0
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
                // LEFT arrow - double tap to GO PREVIOUS
                if (event.key === Qt.Key_Left && !event.isAutoRepeat) {
                    var currentTime = Date.now()
                    if (currentTime - lastLeftTapTime < doubleTapThreshold) {
                        debugInfo = "Double LEFT detected! Going to previous..."
                        skipLeft()  // Double left = previous
                        lastLeftTapTime = 0  // Reset
                        keyHandler.forceActiveFocus()
                    } else {
                        lastLeftTapTime = currentTime
                        debugInfo = "Left arrow tapped once (tap again quickly for previous)"
                    }
                    event.accepted = true
                    return
                }

                // RIGHT arrow - double tap to SKIP FORWARD
                if (event.key === Qt.Key_Right && !event.isAutoRepeat) {
                    var currentTime = Date.now()
                    if (currentTime - lastRightTapTime < doubleTapThreshold) {
                        debugInfo = "Double RIGHT detected! Skipping forward..."
                        skipRight()  // Double right = skip
                        lastRightTapTime = 0  // Reset
                        keyHandler.forceActiveFocus()
                    } else {
                        lastRightTapTime = currentTime
                        debugInfo = "Right arrow tapped once (tap again quickly for skip)"
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
                // Esc+Space = Exit to Analysis
                debugInfo = "ESC+SPACE detected! Exiting to Analysis..."
                saveSession()
                stackView.push("KeyAnalysis.qml", {
                    attemptedKeys: attemptedKeys,
                    appsdata: appsdata,
                    stackView: stackView
                })
                event.accepted = true
                return
            }

            const currentKey = expectedSequence[currentStep]
            var newColors = keyColors.slice()
            var newText = keyText.slice()
            newText[currentStep] = keyEventToString(event)
            var isCorrect = checkKeyPress(event)
            newColors[currentStep] = isCorrect ? "green" : "red"

            debugInfo = "Expected: " + currentKey + ", Got: " + newText[currentStep] + " → " + (isCorrect ? "✓" : "✗")

            keyColors = newColors
            keyText = newText
            activeKeys[currentKey] = true
            currentStep++

            if (currentStep === expectedSequence.length) {
                var isallkeys = keyColors.includes("red")
                attemptedKeys[currentIndex].attempt = true
                attemptedKeys[currentIndex].correct = !isallkeys
                attemptedKeys[currentIndex].keypressed = keyText
                attemptedKeys[currentIndex].color = keyColors

                // Record this attempt with userDataManager
                var success = !isallkeys  // true if no red keys
                var shortcutId = appsdata.test[currentIndex].id || String(currentIndex)
                var categoryId = appsdata.id || "unknown"

                if (userDataManager.currentUser !== "") {
                    userDataManager.recordShortcutAttempt(
                        appsdata.id || "unknown",
                        categoryId,
                        shortcutId,
                        success,
                        mode === "test"
                    )
                    debugInfo = "Recorded: " + (success ? "✓ CORRECT" : "✗ WRONG") + " for " + shortcutId
                } else {
                    debugInfo = "Sequence complete! " + (isallkeys ? "WRONG" : "CORRECT")
                }

                showResult(true)
                nextShortcutTimer.start()
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

            // Arrow key released - no action needed for double-tap mode

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
                    currentStep = 0
                    resetSequence()
                }
            } else {
                delete activeKeys[releasedKey]
                currentStep = 0
                resetSequence()
                debugInfo = "Unknown key released, resetting"
            }

            // Block ALL keys from reaching OS (IPC block)
            event.accepted = true
        }

        // Centered content
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.85
            spacing: 30

            // Progress counter
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 80
                height: 40
                color: "#151515"
                radius: 20
                border.color: "#333333"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: `${count}/${appsdata.test.length}`
                    font.pixelSize: 18
                    font.bold: true
                    color: "#6fda00"
                }
            }

            // Shortcut title - NO KEYS SHOWN (test mode)
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: appsdata.test[currentIndex].title
                font.pixelSize: 32
                font.bold: true
                color: attemptedKeys[currentIndex].attempt ? "#666666" : "#ffffff"

                Rectangle {
                    visible: attemptedKeys[currentIndex].attempt
                    anchors.left: parent.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 70
                    height: 28
                    radius: 14
                    color: attemptedKeys[currentIndex].correct ? "#1a4d1a" : "#4d1a1a"
                    border.color: attemptedKeys[currentIndex].correct ? "#00ff00" : "#ff0000"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: attemptedKeys[currentIndex].correct ? "✓ Done" : "✗ Wrong"
                        font.pixelSize: 12
                        font.bold: true
                        color: attemptedKeys[currentIndex].correct ? "#00ff00" : "#ff0000"
                    }
                }
            }

            // Instruction text
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Type the shortcut keys"
                font.pixelSize: 16
                color: "#888888"
            }

            // Key slots (EMPTY - user has to guess!)
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Repeater {
                    model: expectedSequence.length

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

                        // Show what user typed (NOT the expected key)
                        Text {
                            anchors.centerIn: parent
                            text: keyText[index] || "?"
                            font.pixelSize: 16
                            font.bold: true
                            color: keyColors[index] === "green" ? "#00ff00" :
                                   keyColors[index] === "red" ? "#ff0000" : "#444444"
                        }

                        // Checkmark/X indicator
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

            // Result message
            Text {
                id: resultDisplay
                Layout.alignment: Qt.AlignHCenter
                text: ""
                font.pixelSize: 18
                font.bold: true
                color: "#6fda00"
                opacity: 0

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }

    // Bottom navigation bar
    Rectangle {
        id: bottomBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#111111"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 8

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Double tap LEFT for previous • Double tap RIGHT to skip • ESC+SPACE to exit"
                font.pixelSize: 11
                color: "#888888"
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                // Skip button
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 45
                    enabled: currentStep === 0

                    background: Rectangle {
                        color: parent.enabled ? (parent.hovered ? "#8a8a2a" : "#6a6a1a") : "#2a2a0a"
                        radius: 8
                        border.color: parent.enabled ? "#aaaa44" : "#444422"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: "Skip (→→)"
                        font.pixelSize: 12
                        font.bold: true
                        color: parent.parent.enabled ? "#ffffff" : "#666644"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        skipRight()
                        keyHandler.forceActiveFocus()  // Restore focus
                    }
                }

                Item { width: 20 }

                // Submit button
                Button {
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 45

                    background: Rectangle {
                        color: parent.hovered ? "#7fea10" : "#6fda00"
                        radius: 8
                        border.color: "#8ffa20"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: "Submit Test"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#000000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        saveSession()
                        // No need to restore focus here, we're navigating away
                        stackView.push("Result.qml", {
                            attemptedKeys: attemptedKeys,
                            appsdata: appsdata,
                            stackView: stackView,
                            mode: mode
                        })
                    }
                }
            }
        }
    }

    // Help overlay
    Rectangle {
        anchors.fill: parent
        color: "#dd000000"
        visible: showHelp
        z: 1000

        MouseArea {
            anchors.fill: parent
            onClicked: showHelp = false
        }

        Rectangle {
            width: Math.min(parent.width * 0.85, 480)
            height: Math.min(parent.height * 0.85, 520)
            anchors.centerIn: parent
            color: "#1a1a1a"
            radius: 12
            border.color: "#6fda00"
            border.width: 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 25
                spacing: 18

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "⌨️ Test Mode Help"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#6fda00"
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#333333"
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ColumnLayout {
                        width: parent.width
                        spacing: 15

                        Text {
                            text: "How to Test:"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  1. Read the shortcut name"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  2. Type the keys you think are correct"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  3. Green = Correct, Red = Wrong"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }

                        Rectangle { width: parent.width; height: 1; color: "#252525" }

                        Text {
                            text: "Navigation:"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  Double tap LEFT arrow - Go to previous question"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  Double tap RIGHT arrow - Skip to next question"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  ESC+SPACE - Exit and view analysis"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  Arrows work in shortcuts when expected"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }

                        Rectangle { width: parent.width; height: 1; color: "#252525" }

                        Text {
                            text: "Tips:"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  • Keys are HIDDEN - you must guess!"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  • Use Learning Mode to practice first"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  • All keys work including Esc, arrows, F-keys"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }

                        Item { Layout.fillHeight: true }
                    }
                }

                Button {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40

                    background: Rectangle {
                        color: parent.hovered ? "#7fea10" : "#6fda00"
                        radius: 8
                    }

                    contentItem: Text {
                        text: "Got it!"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#000000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: showHelp = false
                }
            }
        }
    }

    Timer {
        id: nextShortcutTimer
        interval: 1000
        onTriggered: {
            advanceShortcut()
            keyHandler.forceActiveFocus()  // Restore focus for next shortcut
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
                text: "🔧 DEBUG MODE"
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
                text: "Left Double-Tap: " + (lastLeftTapTime > 0 ? "READY" : "Waiting")
                font.pixelSize: 11
                color: lastLeftTapTime > 0 ? "#ffff00" : "#888888"
            }
            Text {
                text: "Right Double-Tap: " + (lastRightTapTime > 0 ? "READY" : "Waiting")
                font.pixelSize: 11
                color: lastRightTapTime > 0 ? "#ffff00" : "#888888"
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
                text: "Question: " + (currentIndex + 1) + "/" + appsdata.test.length
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
