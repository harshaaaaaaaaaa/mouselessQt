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

    // Sequence tracking
    property int sequenceStep: 0
    property var expectedKeys: []
    property var pressedSequence: []
    property var currentlyPressed: ({})

    // ESC+SPACE exit tracking
    property bool escPressed: false
    property bool spacePressed: false

    // Test state
    property var testResults: []
    property int currentIndex: 0
    property var shuffledShortcuts: []
    property bool isAnswered: false
    property bool isCorrect: false
    property var wrongSequence: []

    Component.onCompleted: {
        // Shuffle shortcuts
        var shortcuts = []
        for (var i = 0; i < category.shortcuts.length; i++) {
            shortcuts.push({
                index: i,
                shortcut: category.shortcuts[i],
                id: "shortcut_" + i
            })
        }
        shuffleArray(shortcuts)
        shuffledShortcuts = shortcuts

        userDataManager.startTestSession(appdata.id, category.id)
        resetState()
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

    function resetState() {
        sequenceStep = 0
        pressedSequence = []
        currentlyPressed = {}
        isAnswered = false
        isCorrect = false
        wrongSequence = []
        expectedKeys = shuffledShortcuts[currentIndex].shortcut.keys
    }

    function nextShortcut() {
        currentIndex++
        if (currentIndex >= shuffledShortcuts.length) {
            showTestResults()
            return
        }
        resetState()
    }

    function showTestResults() {
        var correct = 0
        var wrong = 0
        for (var i = 0; i < testResults.length; i++) {
            if (testResults[i].correct) correct++
            else wrong++
        }

        userDataManager.endTestSession(appdata.id, category.id, correct, wrong, testResults.length)

        stackView.push("TestResultsView.qml", {
            appdata: appdata,
            category: category,
            correctCount: correct,
            wrongCount: wrong,
            total: testResults.length,
            stackView: stackView
        })
    }

    function normalizeKey(key) {
        if (key === "Control") return "Ctrl"
        if (key === "up") return "↑"
        if (key === "down") return "↓"
        if (key === "left") return "←"
        if (key === "right") return "→"
        return key
    }

    function checkSequence() {
        if (sequenceStep >= expectedKeys.length) return false
        var expected = normalizeKey(expectedKeys[sequenceStep])
        var pressed = normalizeKey(pressedSequence[sequenceStep])
        return expected === pressed
    }

    function checkComplete() {
        // Check if we have all keys in correct sequence
        if (pressedSequence.length !== expectedKeys.length) return false

        for (var i = 0; i < expectedKeys.length; i++) {
            if (normalizeKey(expectedKeys[i]) !== normalizeKey(pressedSequence[i])) {
                return false
            }
        }
        return true
    }

    function advanceSequence() {
        if (isAnswered) return

        if (checkSequence()) {
            sequenceStep++

            // Check if complete
            if (sequenceStep === expectedKeys.length) {
                isAnswered = true
                isCorrect = true

                // Record result
                var temp = testResults.slice()
                temp.push({
                    shortcutId: shuffledShortcuts[currentIndex].id,
                    correct: true
                })
                testResults = temp

                userDataManager.recordTestResult(appdata.id, category.id, shuffledShortcuts[currentIndex].id, true)
                advanceTimer.start()
            }
        } else {
            // Wrong key - record failure
            isAnswered = true
            isCorrect = false
            wrongSequence = pressedSequence.slice()

            var temp2 = testResults.slice()
            temp2.push({
                shortcutId: shuffledShortcuts[currentIndex].id,
                correct: false
            })
            testResults = temp2

            userDataManager.recordTestResult(appdata.id, category.id, shuffledShortcuts[currentIndex].id, false)
            advanceTimer.start()
        }
    }

    Timer {
        id: advanceTimer
        interval: 2000
        onTriggered: nextShortcut()
    }

    // IPC Key handler
    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                event.accepted = true
                return
            }

            // ESC+SPACE exit
            if (event.key === Qt.Key_Escape) {
                escPressed = true
                if (spacePressed) {
                    stackView.pop()
                }
                event.accepted = true
                return
            }

            if (event.key === Qt.Key_Space) {
                spacePressed = true
                if (escPressed) {
                    stackView.pop()
                }
            }

            // Don't process if already answered
            if (isAnswered || advanceTimer.running) {
                event.accepted = true
                return
            }

            // Convert Qt key to string
            var keyName = ""
            if (event.key === Qt.Key_Control) keyName = "Ctrl"
            else if (event.key === Qt.Key_Shift) keyName = "Shift"
            else if (event.key === Qt.Key_Alt) keyName = "Alt"
            else if (event.key === Qt.Key_Meta) keyName = "Meta"
            else if (event.key === Qt.Key_Up) keyName = "↑"
            else if (event.key === Qt.Key_Down) keyName = "↓"
            else if (event.key === Qt.Key_Left) keyName = "←"
            else if (event.key === Qt.Key_Right) keyName = "→"
            else if (event.key === Qt.Key_Space) keyName = "Space"
            else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) keyName = "Enter"
            else if (event.key === Qt.Key_Tab) keyName = "Tab"
            else if (event.key === Qt.Key_Backspace) keyName = "Backspace"
            else if (event.key === Qt.Key_Delete) keyName = "Delete"
            else if (event.key === Qt.Key_F1) keyName = "F1"
            else if (event.key === Qt.Key_F2) keyName = "F2"
            else if (event.key === Qt.Key_F12) keyName = "F12"
            else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) keyName = String.fromCharCode(event.key)
            else if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) keyName = String.fromCharCode(event.key)

            if (keyName) {
                currentlyPressed[keyName] = true

                if (!pressedSequence.includes(keyName)) {
                    pressedSequence = pressedSequence.concat([keyName])
                    advanceSequence()
                }
            }

            event.accepted = true
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Escape) {
                escPressed = false
            }
            if (event.key === Qt.Key_Space) {
                spacePressed = false
            }

            var keyName = ""
            if (event.key === Qt.Key_Control) keyName = "Ctrl"
            else if (event.key === Qt.Key_Shift) keyName = "Shift"
            else if (event.key === Qt.Key_Alt) keyName = "Alt"
            else if (event.key === Qt.Key_Meta) keyName = "Meta"
            else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) keyName = String.fromCharCode(event.key)

            if (keyName) {
                delete currentlyPressed[keyName]
            }

            event.accepted = true
        }
    }

    property var currentShortcut: shuffledShortcuts[currentIndex]

    // UI Layout
    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.9, 800)
        spacing: 40

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            Button {
                text: "← Back"
                font.pixelSize: 14
                Layout.preferredHeight: 40

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
                text: appdata.title + " · " + category.title + " TEST"
                font.pixelSize: 16
                color: "#888888"
            }
        }

        // Progress
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            Text {
                text: (currentIndex + 1) + " / " + shuffledShortcuts.length
                font.pixelSize: 18
                color: "#888888"
            }

            Text {
                text: "✓ " + testResults.filter(function(r) { return r.correct }).length
                font.pixelSize: 18
                color: "#6fda00"
            }

            Text {
                text: "✗ " + testResults.filter(function(r) { return !r.correct }).length
                font.pixelSize: 18
                color: "#ff4444"
            }
        }

        // Question - only show title (NO KEYS)
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 600
            Layout.preferredHeight: 140
            color: "#151515"
            radius: 12
            border.color: "#6fda00"
            border.width: 2

            Text {
                anchors.centerIn: parent
                width: parent.width - 40
                text: currentShortcut ? currentShortcut.shortcut.title : ""
                font.pixelSize: 32
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }

        // Show result after answer
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 25
            visible: isAnswered

            // What you pressed (if wrong)
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                visible: !isCorrect && wrongSequence.length > 0

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "You pressed:"
                    font.pixelSize: 14
                    color: "#888888"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 10

                    Repeater {
                        model: wrongSequence

                        RowLayout {
                            spacing: 10

                            Rectangle {
                                width: 60
                                height: 60
                                color: "#3a1a1a"
                                radius: 8
                                border.color: "#ff4444"
                                border.width: 2

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                    font.pixelSize: 16
                                    color: "#ff4444"
                                }
                            }

                            Text {
                                visible: index < wrongSequence.length - 1
                                text: "+"
                                font.pixelSize: 20
                                color: "#666666"
                            }
                        }
                    }
                }
            }

            // Correct answer
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: isCorrect ? "Correct answer:" : "Should be:"
                    font.pixelSize: 14
                    color: "#888888"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 15

                    Repeater {
                        model: expectedKeys

                        RowLayout {
                            spacing: 15

                            Rectangle {
                                width: 70
                                height: 70
                                color: isCorrect ? "#1a4d1a" : "#1a1a1a"
                                radius: 12
                                border.color: isCorrect ? "#6fda00" : "#666666"
                                border.width: 2

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: isCorrect ? "#6fda00" : "#ffffff"
                                }
                            }

                            Text {
                                visible: index < expectedKeys.length - 1
                                text: "+"
                                font.pixelSize: 24
                                color: "#666666"
                            }
                        }
                    }
                }
            }

            // Result text
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: isCorrect ? "✓ CORRECT!" : "✗ WRONG"
                font.pixelSize: 28
                font.bold: true
                color: isCorrect ? "#6fda00" : "#ff4444"
            }
        }

        // Exit hint
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            text: "Press ESC + SPACE to exit"
            font.pixelSize: 11
            color: "#555555"
        }
    }

    // IPC indicator
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        width: 120
        height: 35
        color: "#4d1a1a"
        radius: 8
        border.color: "#ff4444"
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: "🔒 IPC MODE"
            font.pixelSize: 11
            font.bold: true
            color: "#ff4444"
        }
    }
}
