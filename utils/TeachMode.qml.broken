import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"
    focus: true

    required property var appdata
    required property var category
    required property StackView stackView

    property int currentIndex: 0
    property int currentStep: 0
    property var expectedSequence: []
    property var activeKeys: ({})
    property var keyColors: []

    Component.onCompleted: {
        resetSequence()
        keyHandler.forceActiveFocus()
    }

    function resetSequence() {
        currentStep = 0
        activeKeys = {}
        expectedSequence = category.shortcuts[currentIndex].keys
        keyColors = new Array(expectedSequence.length).fill("white")
    }

    function advanceShortcut() {
        // Record progress
        var shortcutId = "shortcut_" + currentIndex
        userDataManager.recordTeachProgress(appdata.id, category.id, shortcutId, true)
        userDataManager.saveLastPosition(appdata.id, category.id, currentIndex + 1)

        // Move to next
        currentIndex++
        if (currentIndex >= category.shortcuts.length) {
            // Completed all shortcuts, go back
            stackView.pop()
            return
        }

        resetSequence()
        resultText = ""
    }

    function checkKeyPress(event) {
        var currentKey = expectedSequence[currentStep]

        if (currentKey === "Ctrl" && (event.modifiers & Qt.ControlModifier)) return true
        if (currentKey === "Shift" && (event.modifiers & Qt.ShiftModifier)) return true
        if (currentKey === "Alt" && (event.modifiers & Qt.AltModifier)) return true
        if (currentKey === "Meta" && (event.modifiers & Qt.MetaModifier)) return true

        // Special keys
        if (currentKey === "Enter" && (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)) return true
        if (currentKey === "Space" && event.key === Qt.Key_Space) return true
        if (currentKey === "Tab" && event.key === Qt.Key_Tab) return true
        if (currentKey === "Backspace" && event.key === Qt.Key_Backspace) return true
        if (currentKey === "Escape" && event.key === Qt.Key_Escape) return true
        if (currentKey === "Delete" && event.key === Qt.Key_Delete) return true

        // Arrow keys
        if (currentKey === "up" && event.key === Qt.Key_Up) return true
        if (currentKey === "down" && event.key === Qt.Key_Down) return true
        if (currentKey === "left" && event.key === Qt.Key_Left) return true
        if (currentKey === "right" && event.key === Qt.Key_Right) return true

        // Function keys
        if (currentKey === "F1" && event.key === Qt.Key_F1) return true
        if (currentKey === "F2" && event.key === Qt.Key_F2) return true
        if (currentKey === "F12" && event.key === Qt.Key_F12) return true

        // Regular character keys
        if (currentKey.length === 1) {
            var keyText = String.fromCharCode(event.key)
            if (keyText.toUpperCase() === currentKey.toUpperCase()) return true
        }

        return false
    }

    property string resultText: ""
    property bool escPressed: false
    property bool spacePressed: false

    // IPC Key handler - blocks ALL keys
    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true

        Keys.onPressed: {
            // ESC+SPACE exit combination
            if (event.key === Qt.Key_Escape) {
                escPressed = true
                event.accepted = true
                return
            }

            if (event.key === Qt.Key_Space && escPressed) {
                spacePressed = true
                stackView.pop()
                event.accepted = true
                return
            }

            // Check if current step matches
            if (checkKeyPress(event)) {
                var newColors = keyColors.slice()
                newColors[currentStep] = "#6fda00"
                keyColors = newColors
                currentStep++

                // Check if sequence complete
                if (currentStep === expectedSequence.length) {
                    resultText = "✓ Correct! Moving to next..."
                    nextTimer.start()
                }
            } else {
                resultText = "Press the correct key: " + expectedSequence[currentStep]
            }

            // BLOCK all keys from reaching OS
            event.accepted = true
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Escape) {
                escPressed = false
            }
            if (event.key === Qt.Key_Space) {
                spacePressed = false
            }
            event.accepted = true
        }
    }

    Timer {
        id: nextTimer
        interval: 1500
        onTriggered: advanceShortcut()
    }

    // UI Layout
    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.8
        spacing: 30

        // Header
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: appdata.title + " - " + category.title
            font.pixelSize: 24
            font.bold: true
            color: "#6fda00"
        }

        // Progress
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: (currentIndex + 1) + " / " + category.shortcuts.length
            font.pixelSize: 16
            color: "#888888"
        }

        // Shortcut title
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: category.shortcuts[currentIndex].title
            font.pixelSize: 32
            font.bold: true
            color: "#ffffff"
        }

        // Instruction
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Press these keys in sequence:"
            font.pixelSize: 16
            color: "#888888"
        }

        // Key sequence display
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            Repeater {
                model: expectedSequence

                RowLayout {
                    spacing: 15

                    Rectangle {
                        width: 80
                        height: 80
                        color: keyColors[index] === "#6fda00" ? "#1a4d1a" : "#1a1a1a"
                        radius: 12
                        border.color: keyColors[index] === "#6fda00" ? "#6fda00" : (index === currentStep ? "#6fda00" : "#333333")
                        border.width: index === currentStep ? 3 : 1

                        Behavior on color { ColorAnimation { duration: 200 } }
                        Behavior on border.color { ColorAnimation { duration: 200 } }

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 18
                            font.bold: true
                            color: keyColors[index] === "#6fda00" ? "#6fda00" : "#ffffff"
                        }
                    }

                    Text {
                        visible: index < expectedSequence.length - 1
                        text: "+"
                        font.pixelSize: 24
                        font.bold: true
                        color: "#666666"
                    }
                }
            }
        }

        // Result feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 30
            text: resultText
            font.pixelSize: 16
            font.bold: true
            color: resultText.startsWith("✓") ? "#6fda00" : "#ff4444"
        }

        // Exit instruction
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 40
            text: "Press ESC + SPACE to exit"
            font.pixelSize: 12
            color: "#666666"
        }
    }

    // IPC Mode indicator
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        width: 120
        height: 40
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
