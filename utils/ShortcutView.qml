import QtQuick 2.15
import QtQuick.Controls 2.15

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

    // New navigation state
    property int spaceCount: 0
    property int lastSpaceTime: 0
    property bool escPressed: false

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

        // Save practice session
        if (userDataManager.currentUser !== "") {
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
                text: "2× Space: skip • 3× Space: prev • Esc+Space: exit"
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
            if (event.isAutoRepeat) {
                event.accepted = true  // Block IPC
                return
            }

            // Track Esc key state
            if (event.key === Qt.Key_Escape) {
                escPressed = true
                event.accepted = true
                return
            }

            // Handle Space key for navigation (only when idle)
            if (event.key === Qt.Key_Space && currentStep === 0) {
                var currentTime = Date.now()

                // Reset space count if more than 800ms since last space
                if (currentTime - lastSpaceTime > 800) {
                    spaceCount = 0
                }

                spaceCount++
                lastSpaceTime = currentTime

                // Check if Esc is held for exit
                if (escPressed) {
                    // Esc+Space = Exit to Categories (save session)
                    saveSession()
                    stackView.pop()  // Go back to CategoryView
                    event.accepted = true
                    return
                }

                // Double Space = Skip forward
                if (spaceCount === 2) {
                    skipRight()
                    spaceCount = 0
                    event.accepted = true
                    return
                }

                // Triple Space = Skip backward
                if (spaceCount === 3) {
                    skipLeft()
                    spaceCount = 0
                    event.accepted = true
                    return
                }

                event.accepted = true
                return
            }

            // Process shortcut key press (allow Space if in sequence)
            if (event.key === Qt.Key_Space && currentStep > 0) {
                // Space is part of the shortcut, process normally
            }

            const currentKey = expectedSequence[currentStep]
            var newColors = keyColors.slice()
            newColors[currentStep] = checkKeyPress(event) ? "green" : "red"
            keyColors = newColors
            activeKeys[currentKey] = true
            currentStep++

            if (currentStep === expectedSequence.length) {
                var isallkeys = keyColors.includes("red")
                if (!isallkeys) {
                    showResult(true)
                    nextShortcutTimer.start()
                } else {
                    showResult(false)
                    resetTimer.start()
                }
            }

            // Block ALL keys from reaching OS (IPC block)
            event.accepted = true
        }

        Keys.onReleased: {
            // Reset Esc state
            if (event.key === Qt.Key_Escape) {
                escPressed = false
                event.accepted = true
                return
            }

            const releasedKey = Object.keys(activeKeys).find(key =>
                (key === "Ctrl" && !(event.modifiers & Qt.ControlModifier)) ||
                (key === "Shift" && !(event.modifiers & Qt.ShiftModifier)) ||
                (key === "Alt" && !(event.modifiers & Qt.AltModifier)) ||
                (key === "Enter" && (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)) ||
                (event.key === key.charCodeAt(0)))

            if (event.key === Qt.Key_Space && currentStep == 0) {
                // Space was used to skip, do nothing
            } else if (!releasedKey && currentStep === expectedSequence.length) {
                delete activeKeys[releasedKey]
            } else if (releasedKey) {
                delete activeKeys[releasedKey]
                if (currentStep > 0 && currentStep < expectedSequence.length) {
                    resetSequence()
                }
            } else {
                delete activeKeys[releasedKey]
                resetSequence()
            }

            // Block ALL keys from reaching OS (IPC block)
            event.accepted = true
        }

        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.85
            spacing: 30

            // Counter
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
                    text: `${count}/${appsdata.shortcuts.length}`
                    font.pixelSize: 18
                    font.bold: true
                    color: "#6fda00"
                }
            }

            // Title
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: appsdata.shortcuts[currentIndex].title
                font.pixelSize: 32
                font.bold: true
                color: "#ffffff"
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
        interval: 500
        onTriggered: {
            currentStep = 0
            activeKeys = {}
            keyColors = new Array(appsdata.shortcuts[currentIndex].keys.length).fill("white")
            expectedSequence = appsdata.shortcuts[currentIndex].keys
            resultDisplay.opacity = 0
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
}
