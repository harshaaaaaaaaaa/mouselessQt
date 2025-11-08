import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appdata
    required property var category
    required property StackView stackView

    property int currentIndex: 0
    property var currentShortcut: category.shortcuts[currentIndex]
    property var expectedKeys: currentShortcut.keys
    property int currentStep: 0
    property var pressedKeys: []
    property bool success: false
    property bool failed: false

    // ESC+SPACE tracking
    property bool escPressed: false

    property var learnedIds: []

    Component.onCompleted: {
        root.forceActiveFocus()
    }

    function resetState() {
        currentStep = 0
        pressedKeys = []
        success = false
        failed = false
    }

    function nextShortcut() {
        currentIndex++
        if (currentIndex >= category.shortcuts.length) {
            // Done - go back
            stackView.pop()
            return
        }

        currentShortcut = category.shortcuts[currentIndex]
        expectedKeys = currentShortcut.keys
        resetState()
    }

    function normalizeKey(key) {
        if (key === "Control") return "Ctrl"
        if (key === "up") return "↑"
        if (key === "down") return "↓"
        if (key === "left") return "←"
        if (key === "right") return "→"
        return key
    }

    function checkKey(keyStr) {
        if (currentStep >= expectedKeys.length) return false

        var expected = normalizeKey(expectedKeys[currentStep])
        var pressed = normalizeKey(keyStr)

        return expected.toUpperCase() === pressed.toUpperCase()
    }

    function handleKeyPress(keyStr) {
        if (success) return

        pressedKeys.push(keyStr)

        if (checkKey(keyStr)) {
            currentStep++

            if (currentStep >= expectedKeys.length) {
                // Complete!
                success = true

                var shortcutId = "shortcut_" + currentIndex
                if (!learnedIds.includes(shortcutId)) {
                    learnedIds.push(shortcutId)
                }

                userDataManager.recordTeachProgress(appdata.id, category.id, shortcutId, true)
                userDataManager.saveLastPosition(appdata.id, category.id, currentIndex + 1)

                advanceTimer.start()
            }
        } else {
            // Wrong key
            failed = true
            failTimer.start()
        }
    }

    Timer {
        id: advanceTimer
        interval: 1000
        onTriggered: nextShortcut()
    }

    Timer {
        id: failTimer
        interval: 500
        onTriggered: {
            resetState()
        }
    }

    focus: true
    Keys.onPressed: {
        console.log("Key pressed:", event.key, event.text)

        // ESC+SPACE to exit
        if (event.key === Qt.Key_Escape) {
            escPressed = true
        }
        if (event.key === Qt.Key_Space && escPressed) {
            stackView.pop()
            event.accepted = true
            return
        }

        if (success || advanceTimer.running) {
            event.accepted = true
            return
        }

        var keyStr = ""

        // Get key string
        if (event.key === Qt.Key_Control || event.key === Qt.Key_Meta) {
            keyStr = "Ctrl"
        } else if (event.key === Qt.Key_Shift) {
            keyStr = "Shift"
        } else if (event.key === Qt.Key_Alt) {
            keyStr = "Alt"
        } else if (event.key === Qt.Key_Up) {
            keyStr = "↑"
        } else if (event.key === Qt.Key_Down) {
            keyStr = "↓"
        } else if (event.key === Qt.Key_Left) {
            keyStr = "←"
        } else if (event.key === Qt.Key_Right) {
            keyStr = "→"
        } else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            keyStr = "Enter"
        } else if (event.key === Qt.Key_Space) {
            keyStr = "Space"
        } else if (event.key === Qt.Key_Tab) {
            keyStr = "Tab"
        } else if (event.key === Qt.Key_F1) {
            keyStr = "F1"
        } else if (event.key === Qt.Key_F2) {
            keyStr = "F2"
        } else if (event.key === Qt.Key_F12) {
            keyStr = "F12"
        } else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) {
            keyStr = String.fromCharCode(event.key)
        } else if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
            keyStr = String.fromCharCode(event.key)
        } else if (event.text.length > 0) {
            keyStr = event.text
        }

        console.log("Converted key:", keyStr)

        if (keyStr.length > 0) {
            handleKeyPress(keyStr)
        }

        event.accepted = true
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Escape) {
            escPressed = false
        }
        event.accepted = true
    }

    // UI
    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width - 80, 900)
        spacing: 45

        // Header
        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "← Back"
                font.pixelSize: 14
                Layout.preferredHeight: 42

                background: Rectangle {
                    color: parent.hovered ? "#252525" : "#1a1a1a"
                    radius: 8
                    border.color: "#333333"
                    border.width: 1
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: stackView.pop()
            }

            Item { Layout.fillWidth: true }

            Text {
                text: appdata.title + " · " + category.title
                font.pixelSize: 15
                color: "#888888"
            }
        }

        // Progress
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 130
            Layout.preferredHeight: 42
            color: "#151515"
            radius: 21
            border.color: "#333333"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: (currentIndex + 1) + " / " + category.shortcuts.length
                font.pixelSize: 17
                font.bold: true
                color: "#6fda00"
            }
        }

        // Title
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.maximumWidth: 700
            text: currentShortcut.title
            font.pixelSize: 38
            font.bold: true
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        // Instruction
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: currentStep === 0 ? "Press the keys in order:" : "Next: " + expectedKeys[currentStep]
            font.pixelSize: 15
            color: "#888888"
            visible: !success
        }

        // Keys display
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 18

            Repeater {
                model: expectedKeys

                RowLayout {
                    spacing: 18

                    Rectangle {
                        width: 95
                        height: 95
                        color: {
                            if (success) return "#1a4d1a"
                            if (index < currentStep) return "#1a4d1a"
                            if (failed && index === currentStep) return "#4d1a1a"
                            return "#1a1a1a"
                        }
                        radius: 14
                        border.color: {
                            if (success) return "#6fda00"
                            if (failed && index === currentStep) return "#ff4444"
                            if (index === currentStep) return "#6fda00"
                            if (index < currentStep) return "#6fda00"
                            return "#333333"
                        }
                        border.width: index === currentStep ? 3 : 2

                        Behavior on color { ColorAnimation { duration: 200 } }
                        Behavior on border.color { ColorAnimation { duration: 200 } }

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 24
                            font.bold: true
                            color: {
                                if (success) return "#6fda00"
                                if (index < currentStep) return "#6fda00"
                                return "#ffffff"
                            }
                        }

                        // Checkmark
                        Text {
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: 8
                            text: "✓"
                            font.pixelSize: 18
                            font.bold: true
                            color: "#6fda00"
                            visible: index < currentStep || success
                        }
                    }

                    Text {
                        visible: index < expectedKeys.length - 1
                        text: "+"
                        font.pixelSize: 32
                        font.bold: true
                        color: "#555555"
                    }
                }
            }
        }

        // Feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 45
            text: {
                if (success) return "✓ Perfect!"
                if (failed) return "✗ Wrong key, try again"
                return ""
            }
            font.pixelSize: 26
            font.bold: true
            color: success ? "#6fda00" : "#ff4444"
        }

        // Debug info
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Pressed: " + pressedKeys.join(", ")
            font.pixelSize: 12
            color: "#555555"
            visible: pressedKeys.length > 0
        }

        // Exit hint
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            text: "Press ESC + SPACE to exit"
            font.pixelSize: 12
            color: "#555555"
        }
    }

    // IPC indicator
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        width: 130
        height: 38
        color: "#4d1a1a"
        radius: 8
        border.color: "#ff4444"
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: "🔒 IPC MODE"
            font.pixelSize: 12
            font.bold: true
            color: "#ff4444"
        }
    }
}
