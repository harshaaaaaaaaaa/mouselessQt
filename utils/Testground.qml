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

    // State management
    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []
    property var keyText: []
    property int count: 1
    property bool showHelp: false

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
        case Qt.Key_Up: return "Up"
        case Qt.Key_Down: return "Down"
        case Qt.Key_Left: return "Left"
        case Qt.Key_Right: return "Right"
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

        if (currentKey === "Ctrl") {
            keyMatch = event.modifiers & Qt.ControlModifier
        } else if (currentKey === "Shift") {
            keyMatch = event.modifiers & Qt.ShiftModifier
        } else if (currentKey === "Enter") {
            keyMatch = (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
        } else if (currentKey === "Alt") {
            keyMatch = event.modifiers & Qt.AltModifier
        } else if (currentKey === "PageDown") {
            keyMatch = event.key === Qt.Key_PageDown
        } else if (currentKey === "PageUp") {
            keyMatch = event.key === Qt.Key_PageUp
        } else if (currentKey === "Space") {
            keyMatch = event.key === Qt.Key_Space
        } else if (currentKey === "Tab") {
            keyMatch = event.key === Qt.Qt.Key_Tab
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
        } else if (currentKey === "Up") {
            keyMatch = event.key === Qt.Key_Up
        } else if (currentKey === "Down") {
            keyMatch = event.key === Qt.Key_Down
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
            if (event.isAutoRepeat) return

            // Ctrl+Esc to exit
            if ((event.modifiers & Qt.ControlModifier) && event.key === Qt.Key_Escape) {
                saveSession()
                stackView.pop()
                event.accepted = true
                return
            }

            // Alt+navigation (conflict-free)
            if (currentStep == 0) {
                if ((event.modifiers & Qt.AltModifier) && event.key === Qt.Key_Right) {
                    skipRight()
                    event.accepted = true
                    return
                } else if ((event.modifiers & Qt.AltModifier) && event.key === Qt.Key_Left) {
                    skipLeft()
                    event.accepted = true
                    return
                }
            }

            // Regular arrow navigation
            if (event.key === Qt.Key_Right && currentStep == 0) {
                skipRight()
            } else if (event.key === Qt.Key_Left && currentStep == 0) {
                skipLeft()
            } else {
                const currentKey = expectedSequence[currentStep]
                var newColors = keyColors.slice()
                var newText = keyText.slice()
                newText[currentStep] = keyEventToString(event)
                newColors[currentStep] = checkKeyPress(event) ? "green" : "red"

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

                    showResult(true)
                    nextShortcutTimer.start()
                }
            }
        }

        Keys.onReleased: {
            const releasedKey = Object.keys(activeKeys).find(key =>
                (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
                (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
                (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
                (key === "Enter" && (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)) ||
                (event.key === key.charCodeAt(0)))

            if ((event.key === Qt.Key_Right || event.key === Qt.Key_Left) && currentStep == 0) {
                resetSequence()
            } else if (!releasedKey && currentStep === expectedSequence.length) {
                delete activeKeys[releasedKey]
            } else if (releasedKey) {
                delete activeKeys[releasedKey]
                if (currentStep > 0 && currentStep < expectedSequence.length) {
                    currentStep = 0
                    resetSequence()
                }
            } else {
                delete activeKeys[releasedKey]
                currentStep = 0
                resetSequence()
            }
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

            // Shortcut title
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

            // Keys row
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Repeater {
                    model: appsdata.test[currentIndex].keys

                    Rectangle {
                        width: 70
                        height: 50
                        radius: 8
                        color: keyColors[index] === "green" ? "#1a4d1a" :
                               keyColors[index] === "red" ? "#4d1a1a" : "#1a1a1a"
                        border.color: keyColors[index] === "green" ? "#00ff00" :
                                     keyColors[index] === "red" ? "#ff0000" : "#444444"
                        border.width: 2

                        // Smooth scale animation
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
                            text: keyText[index] || modelData
                            font.pixelSize: 16
                            font.bold: true
                            color: keyColors[index] === "green" ? "#00ff00" :
                                   keyColors[index] === "red" ? "#ff0000" : "#888888"
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
        height: 70
        color: "#111111"

        RowLayout {
            anchors.centerIn: parent
            spacing: 12

            // Previous button
            Button {
                Layout.preferredWidth: 100
                Layout.preferredHeight: 45
                enabled: currentStep === 0

                background: Rectangle {
                    color: parent.enabled ? (parent.hovered ? "#252525" : "#1a1a1a") : "#0f0f0f"
                    radius: 8
                    border.color: parent.enabled ? "#444444" : "#222222"
                    border.width: 1
                }

                contentItem: Text {
                    text: "← Previous"
                    font.pixelSize: 13
                    font.bold: true
                    color: parent.parent.enabled ? "#ffffff" : "#444444"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: skipLeft()
            }

            // Skip button
            Button {
                Layout.preferredWidth: 80
                Layout.preferredHeight: 45
                enabled: currentStep === 0

                background: Rectangle {
                    color: parent.enabled ? (parent.hovered ? "#8a8a2a" : "#6a6a1a") : "#2a2a0a"
                    radius: 8
                    border.color: parent.enabled ? "#aaaa44" : "#444422"
                    border.width: 1
                }

                contentItem: Text {
                    text: "Skip ⤵"
                    font.pixelSize: 13
                    font.bold: true
                    color: parent.parent.enabled ? "#ffffff" : "#666644"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: skipRight()
            }

            // Next button
            Button {
                Layout.preferredWidth: 100
                Layout.preferredHeight: 45
                enabled: currentStep === 0

                background: Rectangle {
                    color: parent.enabled ? (parent.hovered ? "#252525" : "#1a1a1a") : "#0f0f0f"
                    radius: 8
                    border.color: parent.enabled ? "#444444" : "#222222"
                    border.width: 1
                }

                contentItem: Text {
                    text: "Next →"
                    font.pixelSize: 13
                    font.bold: true
                    color: parent.parent.enabled ? "#ffffff" : "#444444"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: skipRight()
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
                    stackView.push("Result.qml", {
                        attemptedKeys: attemptedKeys,
                        appsdata: appsdata,
                        stackView: stackView
                    })
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
                    text: "⌨️ Keyboard Shortcuts"
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

                        // Navigation section
                        Text {
                            text: "Navigation (when idle):"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  ← → Arrow keys - Previous/Next question"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  Alt+← Alt+→ - Safe navigation (no conflicts)"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }

                        Rectangle { width: parent.width; height: 1; color: "#252525" }

                        // Exit section
                        Text {
                            text: "Exit & Save:"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  Ctrl+Esc - Save progress and exit"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }

                        Rectangle { width: parent.width; height: 1; color: "#252525" }

                        // Testing section
                        Text {
                            text: "Testing:"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                        Text {
                            text: "  🟢 Green - Correct key pressed"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  🔴 Red - Wrong key pressed"
                            font.pixelSize: 13
                            color: "#cccccc"
                        }
                        Text {
                            text: "  Release early - Reset and try again"
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
        onTriggered: advanceShortcut()
    }
}
