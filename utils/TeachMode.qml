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

    // Strict sequence tracking
    property int sequenceStep: 0
    property var expectedKeys: []
    property var pressedSequence: []  // Tracks keys in order pressed
    property var currentlyPressed: ({})  // Currently held keys

    // ESC+SPACE exit tracking
    property bool escPressed: false
    property bool spacePressed: false

    // Learning state
    property var trainedIds: []
    property var learnedIds: []
    property var skippedIds: []
    property int currentShortcutIndex: 0
    property var currentShortcut: null
    property bool success: false
    property bool showFailed: false

    // Computed
    property var shortcuts: category.shortcuts
    property bool finished: learnedIds.length > 0 && learnedIds.length === shortcuts.length && skippedIds.length === 0

    Component.onCompleted: {
        setNextShortcut()
        keyHandler.forceActiveFocus()
    }

    function setNextShortcut() {
        if (finished) {
            stackView.pop()
            return
        }

        // Weighted random selection (Mouseless pattern)
        var unseenShortcuts = []
        var trainedShortcuts = []
        var learnedShortcuts = []

        for (var i = 0; i < shortcuts.length; i++) {
            var id = "shortcut_" + i
            if (skippedIds.includes(id)) continue

            if (!trainedIds.includes(id) && !learnedIds.includes(id)) {
                unseenShortcuts.push({index: i, shortcut: shortcuts[i], id: id})
            } else if (trainedIds.includes(id)) {
                trainedShortcuts.push({index: i, shortcut: shortcuts[i], id: id})
            } else if (learnedIds.includes(id)) {
                learnedShortcuts.push({index: i, shortcut: shortcuts[i], id: id})
            }
        }

        var shortcutSet = []
        for (var j = 0; j < 90; j++) shortcutSet = shortcutSet.concat(unseenShortcuts)
        for (var k = 0; k < 50; k++) shortcutSet = shortcutSet.concat(trainedShortcuts)
        for (var l = 0; l < 10; l++) shortcutSet = shortcutSet.concat(learnedShortcuts)

        if (shortcutSet.length === 0) {
            stackView.pop()
            return
        }

        var randomIndex = Math.floor(Math.random() * shortcutSet.length)
        var selected = shortcutSet[randomIndex]

        currentShortcutIndex = selected.index
        currentShortcut = selected.shortcut
        expectedKeys = currentShortcut.keys

        resetState()
    }

    function resetState() {
        sequenceStep = 0
        pressedSequence = []
        currentlyPressed = {}
        success = false
        showFailed = false
    }

    function addToTrainedIds(id) {
        if (!trainedIds.includes(id)) {
            trainedIds = trainedIds.concat([id])
        }
        learnedIds = learnedIds.filter(function(lid) { return lid !== id })
    }

    function addToLearnedIds(id) {
        if (!learnedIds.includes(id)) {
            learnedIds = learnedIds.concat([id])
        }
        trainedIds = trainedIds.filter(function(tid) { return tid !== id })
        userDataManager.recordTeachProgress(appdata.id, category.id, id, true)
        userDataManager.saveLastPosition(appdata.id, category.id, currentShortcutIndex + 1)
    }

    function skip() {
        var id = "shortcut_" + currentShortcutIndex
        if (!skippedIds.includes(id)) {
            skippedIds = skippedIds.concat([id])
        }
        setNextShortcut()
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
        // Check if current step matches expected
        if (sequenceStep >= expectedKeys.length) return false

        var expected = normalizeKey(expectedKeys[sequenceStep])
        var pressed = normalizeKey(pressedSequence[sequenceStep])

        return expected === pressed
    }

    function advanceSequence() {
        if (checkSequence()) {
            sequenceStep++

            // Check if complete
            if (sequenceStep === expectedKeys.length) {
                success = true
                showFailed = false

                var id = "shortcut_" + currentShortcutIndex
                var isTest = trainedIds.includes(id) || learnedIds.includes(id)

                if (isTest) {
                    addToLearnedIds(id)
                } else {
                    addToTrainedIds(id)
                }

                advanceTimer.start()
            }
        } else {
            // Wrong key - show failed
            showFailed = true
            failedTimer.start()
        }
    }

    Timer {
        id: advanceTimer
        interval: 1000
        onTriggered: setNextShortcut()
    }

    Timer {
        id: failedTimer
        interval: 500
        onTriggered: {
            showFailed = false
            resetState()
        }
    }

    // IPC Key handler - BLOCKS ALL OS SHORTCUTS
    Item {
        id: keyHandler
        anchors.fill: parent
        focus: true

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                event.accepted = true
                return
            }

            // ESC+SPACE exit mechanism
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
                // Don't return - Space might be part of shortcut
            }

            // Don't process if already showing result
            if (success || advanceTimer.running) {
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
            else keyName = event.text

            if (keyName) {
                // Add to currently pressed
                currentlyPressed[keyName] = true

                // Add to sequence if not already there
                if (!pressedSequence.includes(keyName)) {
                    pressedSequence = pressedSequence.concat([keyName])
                    advanceSequence()
                }
            }

            // BLOCK ALL KEYS - IPC MODE
            event.accepted = true
        }

        Keys.onReleased: {
            // Reset ESC/SPACE flags
            if (event.key === Qt.Key_Escape) {
                escPressed = false
            }
            if (event.key === Qt.Key_Space) {
                spacePressed = false
            }

            // Remove from currently pressed
            var keyName = ""
            if (event.key === Qt.Key_Control) keyName = "Ctrl"
            else if (event.key === Qt.Key_Shift) keyName = "Shift"
            else if (event.key === Qt.Key_Alt) keyName = "Alt"
            else if (event.key === Qt.Key_Meta) keyName = "Meta"
            else if (event.key === Qt.Key_Up) keyName = "↑"
            else if (event.key === Qt.Key_Down) keyName = "↓"
            else if (event.key === Qt.Key_Left) keyName = "←"
            else if (event.key === Qt.Key_Right) keyName = "→"
            else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) keyName = String.fromCharCode(event.key)

            if (keyName) {
                delete currentlyPressed[keyName]
            }

            event.accepted = true
        }
    }

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
                text: appdata.title + " · " + category.title
                font.pixelSize: 16
                color: "#888888"
            }
        }

        // Shortcut title
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            text: currentShortcut ? currentShortcut.title : ""
            font.pixelSize: 36
            font.bold: true
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        // Expected keys - show in sequence order with glow
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            Repeater {
                model: expectedKeys

                RowLayout {
                    spacing: 15

                    Rectangle {
                        width: 90
                        height: 90
                        color: {
                            if (success) return "#1a4d1a"
                            if (index < sequenceStep) return "#1a4d1a"  // Already pressed correctly
                            if (index === sequenceStep && currentlyPressed[normalizeKey(modelData)]) return "#2a4d2a"  // Currently pressing
                            return "#1a1a1a"
                        }
                        radius: 12
                        border.color: {
                            if (success) return "#6fda00"
                            if (showFailed && index === sequenceStep) return "#ff4444"
                            if (index < sequenceStep) return "#6fda00"  // Already correct
                            if (index === sequenceStep) return "#6fda00"  // Current step
                            return "#333333"
                        }
                        border.width: index === sequenceStep ? 3 : 2

                        Behavior on color { ColorAnimation { duration: 150 } }
                        Behavior on border.color { ColorAnimation { duration: 150 } }

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 22
                            font.bold: true
                            color: index < sequenceStep ? "#6fda00" : "#ffffff"
                        }

                        // Checkmark for completed steps
                        Text {
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: 5
                            text: "✓"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                            visible: index < sequenceStep
                        }
                    }

                    Text {
                        visible: index < expectedKeys.length - 1
                        text: "+"
                        font.pixelSize: 28
                        font.bold: true
                        color: "#666666"
                    }
                }
            }
        }

        // Sequence instruction
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: {
                if (success) return ""
                if (sequenceStep === 0) return "Press keys in order, starting with " + expectedKeys[0]
                if (sequenceStep < expectedKeys.length) return "Next: press " + expectedKeys[sequenceStep]
                return ""
            }
            font.pixelSize: 14
            color: "#888888"
        }

        // Feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            text: {
                if (success) return "✓ Correct!"
                if (showFailed) return "✗ Wrong key! Start over"
                return ""
            }
            font.pixelSize: 24
            font.bold: true
            color: success ? "#6fda00" : "#ff4444"
        }

        // Progress + Skip
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 20
            spacing: 20

            Rectangle {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 40
                color: "#151515"
                radius: 20
                border.color: "#333333"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: learnedIds.length + " / " + shortcuts.length
                    font.pixelSize: 16
                    font.bold: true
                    color: "#6fda00"
                }
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "Skip →"
                font.pixelSize: 14
                Layout.preferredHeight: 40
                Layout.preferredWidth: 100

                background: Rectangle {
                    color: parent.hovered ? "#353535" : "#252525"
                    radius: 8
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "#888888"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: skip()
            }
        }

        // Exit hint
        Text {
            Layout.alignment: Qt.AlignHCenter
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
