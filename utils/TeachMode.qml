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
    property var currentlyHeld: ({})  // Keys currently being held down
    property bool success: false
    property bool failed: false

    // ESC+SPACE tracking
    property bool escPressed: false

    property var learnedIds: []

    Component.onCompleted: {
        root.forceActiveFocus()
    }

    function resetState() {
        currentlyHeld = {}
        success = false
        failed = false
    }

    function nextShortcut() {
        currentIndex++
        if (currentIndex >= category.shortcuts.length) {
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
        return key.toUpperCase()
    }

    function checkIfComplete() {
        // Check if all expected keys are currently held
        var heldKeys = Object.keys(currentlyHeld)

        if (heldKeys.length !== expectedKeys.length) {
            return false
        }

        // Check each expected key is held
        for (var i = 0; i < expectedKeys.length; i++) {
            var expected = normalizeKey(expectedKeys[i])
            var found = false

            for (var j = 0; j < heldKeys.length; j++) {
                if (normalizeKey(heldKeys[j]) === expected) {
                    found = true
                    break
                }
            }

            if (!found) {
                return false
            }
        }

        return true
    }

    Timer {
        id: checkTimer
        interval: 50
        repeat: true
        running: !success
        onTriggered: {
            if (checkIfComplete()) {
                success = true
                repeat = false

                var shortcutId = "shortcut_" + currentIndex
                if (!learnedIds.includes(shortcutId)) {
                    learnedIds.push(shortcutId)
                }

                userDataManager.recordTeachProgress(appdata.id, category.id, shortcutId, true)
                userDataManager.saveLastPosition(appdata.id, category.id, currentIndex + 1)

                advanceTimer.start()
            }
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
            failed = false
        }
    }

    focus: true
    Keys.onPressed: {
        if (event.isAutoRepeat) {
            event.accepted = true
            return
        }

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

        if (keyStr.length > 0) {
            // Add to currently held keys
            var newHeld = currentlyHeld
            newHeld[keyStr] = true
            currentlyHeld = newHeld
            currentlyHeldChanged()
        }

        event.accepted = true
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Escape) {
            escPressed = false
        }

        var keyStr = ""
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
        } else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) {
            keyStr = String.fromCharCode(event.key)
        } else if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
            keyStr = String.fromCharCode(event.key)
        }

        if (keyStr.length > 0) {
            // Remove from currently held
            var newHeld = currentlyHeld
            delete newHeld[keyStr]
            currentlyHeld = newHeld
            currentlyHeldChanged()
        }

        event.accepted = true
    }

    // Centered main content
    Item {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            width: Math.min(parent.width - 100, 900)
            spacing: 50

            // Header
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: "← Back"
                    font.pixelSize: 14
                    Layout.preferredHeight: 42
                    Layout.preferredWidth: 110

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
                text: "Press and hold all keys together"
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
                                var normalized = normalizeKey(modelData)
                                var isHeld = false
                                for (var key in currentlyHeld) {
                                    if (normalizeKey(key) === normalized) {
                                        isHeld = true
                                        break
                                    }
                                }
                                return isHeld ? "#2a4d2a" : "#1a1a1a"
                            }
                            radius: 14
                            border.color: {
                                if (success) return "#6fda00"
                                if (failed) return "#ff4444"
                                var normalized = normalizeKey(modelData)
                                for (var key in currentlyHeld) {
                                    if (normalizeKey(key) === normalized) {
                                        return "#6fda00"
                                    }
                                }
                                return "#333333"
                            }
                            border.width: 2

                            Behavior on color { ColorAnimation { duration: 100 } }
                            Behavior on border.color { ColorAnimation { duration: 100 } }

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 24
                                font.bold: true
                                color: {
                                    if (success) return "#6fda00"
                                    var normalized = normalizeKey(modelData)
                                    for (var key in currentlyHeld) {
                                        if (normalizeKey(key) === normalized) {
                                            return "#6fda00"
                                        }
                                    }
                                    return "#ffffff"
                                }
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
                    if (failed) return "✗ Wrong combination"
                    return ""
                }
                font.pixelSize: 26
                font.bold: true
                color: success ? "#6fda00" : "#ff4444"
            }

            // Currently held keys debug
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Holding: " + Object.keys(currentlyHeld).join(" + ")
                font.pixelSize: 12
                color: "#555555"
                visible: Object.keys(currentlyHeld).length > 0
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
