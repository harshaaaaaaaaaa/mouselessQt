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

    property var shuffledShortcuts: []
    property int currentIndex: 0
    property int currentStep: 0
    property var expectedSequence: []
    property var activeKeys: ({})
    property var pressedKeys: []
    property bool sequenceComplete: false

    property int correctCount: 0
    property int wrongCount: 0

    Component.onCompleted: {
        // Shuffle shortcuts for random order
        var shortcuts = []
        for (var i = 0; i < category.shortcuts.length; i++) {
            shortcuts.push(category.shortcuts[i])
        }
        shuffleArray(shortcuts)
        shuffledShortcuts = shortcuts

        userDataManager.startTestSession(appdata.id, category.id)
        resetSequence()
        keyHandler.forceActiveFocus()
    }

    function shuffleArray(array) {
        for (var i = array.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1))
            var temp = array[i]
            array[i] = array[j]
            array[j] = temp
        }
    }

    function resetSequence() {
        currentStep = 0
        activeKeys = {}
        pressedKeys = []
        sequenceComplete = false
        expectedSequence = shuffledShortcuts[currentIndex].keys
        resultText = ""
    }

    function advanceShortcut() {
        currentIndex++
        if (currentIndex >= shuffledShortcuts.length) {
            // Test complete - show results
            userDataManager.endTestSession(
                appdata.id,
                category.id,
                correctCount,
                wrongCount,
                shuffledShortcuts.length
            )

            stackView.push("TestResultsView.qml", {
                appdata: appdata,
                category: category,
                correctCount: correctCount,
                wrongCount: wrongCount,
                total: shuffledShortcuts.length,
                stackView: stackView
            })
            return
        }

        resetSequence()
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

    function getKeyName(event) {
        if (event.modifiers & Qt.ControlModifier) return "Ctrl"
        if (event.modifiers & Qt.ShiftModifier) return "Shift"
        if (event.modifiers & Qt.AltModifier) return "Alt"
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) return "Enter"
        if (event.key === Qt.Key_Space) return "Space"
        if (event.key === Qt.Key_Up) return "↑"
        if (event.key === Qt.Key_Down) return "↓"
        if (event.key === Qt.Key_Left) return "←"
        if (event.key === Qt.Key_Right) return "→"
        if (event.key === Qt.Key_F12) return "F12"
        return String.fromCharCode(event.key)
    }

    property string resultText: ""
    property bool escPressed: false

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
                stackView.pop()
                event.accepted = true
                return
            }

            if (sequenceComplete) {
                event.accepted = true
                return
            }

            // Check if current step matches
            if (checkKeyPress(event)) {
                pressedKeys.push(getKeyName(event))
                pressedKeysChanged()
                currentStep++

                // Check if sequence complete
                if (currentStep === expectedSequence.length) {
                    sequenceComplete = true
                    correctCount++
                    resultText = "✓ CORRECT!"
                    resultColor = "#6fda00"

                    // Record this as correct
                    var shortcutId = "shortcut_" + currentIndex
                    userDataManager.recordTestResult(appdata.id, category.id, shortcutId, true)

                    nextTimer.start()
                }
            } else {
                // Wrong key - mark wrong and move to next
                sequenceComplete = true
                wrongCount++
                resultText = "✗ WRONG!"
                resultColor = "#ff4444"

                // Show what they pressed
                pressedKeys.push(getKeyName(event))
                pressedKeysChanged()

                // Record this as wrong
                var shortcutId2 = "shortcut_" + currentIndex
                userDataManager.recordTestResult(appdata.id, category.id, shortcutId2, false)

                nextTimer.start()
            }

            // BLOCK all keys from reaching OS
            event.accepted = true
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Escape) {
                escPressed = false
            }
            event.accepted = true
        }
    }

    Timer {
        id: nextTimer
        interval: 1500
        onTriggered: advanceShortcut()
    }

    property string resultColor: "#6fda00"

    // UI Layout
    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.8
        spacing: 30

        // Header
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: appdata.title + " - " + category.title + " TEST"
            font.pixelSize: 24
            font.bold: true
            color: "#6fda00"
        }

        // Progress
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            Text {
                text: (currentIndex + 1) + " / " + shuffledShortcuts.length
                font.pixelSize: 16
                color: "#888888"
            }

            Text {
                text: "✓ " + correctCount
                font.pixelSize: 16
                color: "#6fda00"
            }

            Text {
                text: "✗ " + wrongCount
                font.pixelSize: 16
                color: "#ff4444"
            }
        }

        // Question - only show TITLE, not keys
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 600
            Layout.preferredHeight: 150
            color: "#151515"
            radius: 12
            border.color: "#6fda00"
            border.width: 2

            Text {
                anchors.centerIn: parent
                text: shuffledShortcuts[currentIndex].title
                font.pixelSize: 28
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Instruction
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: sequenceComplete ? "" : "Type the correct shortcut for this action"
            font.pixelSize: 16
            color: "#888888"
        }

        // Show pressed keys
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 60
            spacing: 10

            Repeater {
                model: pressedKeys

                RowLayout {
                    spacing: 10

                    Rectangle {
                        width: 60
                        height: 60
                        color: "#1a1a1a"
                        radius: 8
                        border.color: "#666666"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 16
                            font.bold: true
                            color: "#ffffff"
                        }
                    }

                    Text {
                        visible: index < pressedKeys.length - 1
                        text: "+"
                        font.pixelSize: 18
                        color: "#666666"
                    }
                }
            }
        }

        // Result feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            text: resultText
            font.pixelSize: 24
            font.bold: true
            color: resultColor
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
