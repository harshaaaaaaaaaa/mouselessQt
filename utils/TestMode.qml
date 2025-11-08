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

    // Keyboard state tracking
    property var pressedKeys: []
    property var specialKeys: []
    property var regularKeys: []
    property var failedKeys: []

    // Test state
    property var testResults: []
    property int currentIndex: 0
    property var shuffledShortcuts: []
    property bool success: false
    property bool testFailed: false
    property bool showResult: false

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
        pressedKeys = []
        specialKeys = []
        regularKeys = []
        failedKeys = []
        success = false
        testFailed = false
        showResult = false
    }

    function nextShortcut() {
        currentIndex++
        if (currentIndex >= shuffledShortcuts.length) {
            // Test complete - show results
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
        if (key === "Ctrl" || key === "Control") return "Ctrl"
        if (key === "up") return "↑"
        if (key === "down") return "↓"
        if (key === "left") return "←"
        if (key === "right") return "→"
        return key.toUpperCase()
    }

    function checkMatch() {
        var current = shuffledShortcuts[currentIndex]
        if (!current) return false

        var expected = current.shortcut.keys
        var pressed = specialKeys.concat(regularKeys)

        if (pressed.length !== expected.length) return false

        for (var i = 0; i < expected.length; i++) {
            var expectedKey = normalizeKey(expected[i])
            var found = false
            for (var j = 0; j < pressed.length; j++) {
                if (normalizeKey(pressed[j]) === expectedKey) {
                    found = true
                    break
                }
            }
            if (!found) return false
        }

        return true
    }

    function handleShortcut() {
        if (showResult || advanceTimer.running) return

        if (checkMatch()) {
            success = true
            testFailed = false
            showResult = true

            // Record result
            var temp = testResults.slice()
            temp.push({
                shortcutId: shuffledShortcuts[currentIndex].id,
                correct: true
            })
            testResults = temp

            userDataManager.recordTestResult(appdata.id, category.id, shuffledShortcuts[currentIndex].id, true)
            advanceTimer.start()
        } else {
            if (!testFailed) {
                // First failure - save what they pressed
                failedKeys = pressedKeys.slice()
                testFailed = true
                showResult = true
            } else {
                // Second attempt failed - mark wrong and move on
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
    }

    Timer {
        id: advanceTimer
        interval: 1500
        onTriggered: nextShortcut()
    }

    // Key handler
    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true

        Keys.onPressed: {
            // Update special keys
            var newSpecial = []
            if (event.modifiers & Qt.ControlModifier) newSpecial.push("Ctrl")
            if (event.modifiers & Qt.ShiftModifier) newSpecial.push("Shift")
            if (event.modifiers & Qt.AltModifier) newSpecial.push("Alt")
            if (event.modifiers & Qt.MetaModifier) newSpecial.push("Meta")
            specialKeys = newSpecial

            if (showResult || advanceTimer.running) {
                event.accepted = true
                return
            }

            // Handle regular keys
            if (event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Return ||
                event.key === Qt.Key_Enter ||
                event.key === Qt.Key_Tab ||
                event.key === Qt.Key_Space ||
                event.key === Qt.Key_Backspace ||
                event.key === Qt.Key_Delete ||
                event.key === Qt.Key_Up ||
                event.key === Qt.Key_Down ||
                event.key === Qt.Key_Left ||
                event.key === Qt.Key_Right ||
                event.key === Qt.Key_F1 ||
                event.key === Qt.Key_F2 ||
                event.key === Qt.Key_F12 ||
                (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) ||
                (event.key >= Qt.Key_0 && event.key <= Qt.Key_9)) {

                var keyName = ""
                if (event.key === Qt.Key_Up) keyName = "↑"
                else if (event.key === Qt.Key_Down) keyName = "↓"
                else if (event.key === Qt.Key_Left) keyName = "←"
                else if (event.key === Qt.Key_Right) keyName = "→"
                else if (event.key === Qt.Key_Space) keyName = "Space"
                else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) keyName = "Enter"
                else if (event.key === Qt.Key_Escape) keyName = "Escape"
                else if (event.key === Qt.Key_Tab) keyName = "Tab"
                else if (event.key === Qt.Key_Backspace) keyName = "Backspace"
                else if (event.key === Qt.Key_Delete) keyName = "Delete"
                else if (event.key === Qt.Key_F1) keyName = "F1"
                else if (event.key === Qt.Key_F2) keyName = "F2"
                else if (event.key === Qt.Key_F12) keyName = "F12"
                else keyName = String.fromCharCode(event.key)

                regularKeys = [keyName]
                pressedKeys = specialKeys.concat(regularKeys)

                handleShortcut()
            }

            event.accepted = true
        }

        Keys.onReleased: {
            var newSpecial = []
            if (event.modifiers & Qt.ControlModifier) newSpecial.push("Ctrl")
            if (event.modifiers & Qt.ShiftModifier) newSpecial.push("Shift")
            if (event.modifiers & Qt.AltModifier) newSpecial.push("Alt")
            if (event.modifiers & Qt.MetaModifier) newSpecial.push("Meta")
            specialKeys = newSpecial
            regularKeys = []
            if (!showResult) {
                pressedKeys = specialKeys.concat(regularKeys)
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
                text: "← Back to Sets"
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

        // Question - only show title
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

        // Show keys when test failed or success
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            visible: showResult

            // Failed attempt (if any)
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                visible: testFailed && failedKeys.length > 0

                Text {
                    text: "You pressed:"
                    font.pixelSize: 14
                    color: "#888888"
                }

                Repeater {
                    model: failedKeys

                    Rectangle {
                        width: 60
                        height: 60
                        color: "#3a1a1a"
                        radius: 8
                        border.color: "#ff4444"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 16
                            color: "#ff4444"
                        }
                    }
                }
            }

            // Correct answer
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                visible: testFailed || success

                Text {
                    text: testFailed ? "Correct answer:" : ""
                    font.pixelSize: 14
                    color: "#888888"
                    visible: testFailed
                }

                Repeater {
                    model: currentShortcut ? currentShortcut.shortcut.keys : []

                    RowLayout {
                        spacing: 15

                        Rectangle {
                            width: 70
                            height: 70
                            color: success ? "#1a4d1a" : "#1a1a1a"
                            radius: 12
                            border.color: success ? "#6fda00" : "#666666"
                            border.width: 2

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 18
                                font.bold: true
                                color: success ? "#6fda00" : "#ffffff"
                            }
                        }

                        Text {
                            visible: index < (currentShortcut ? currentShortcut.shortcut.keys.length - 1 : 0)
                            text: "+"
                            font.pixelSize: 24
                            color: "#666666"
                        }
                    }
                }
            }
        }

        // Feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            text: {
                if (success) return "✓ CORRECT!"
                if (testFailed) return "✗ WRONG - Try once more"
                return ""
            }
            font.pixelSize: 24
            font.bold: true
            color: success ? "#6fda00" : "#ff4444"
        }
    }
}
