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

    // Keyboard state tracking (like Mouseless Keyboard.js)
    property var pressedKeys: []
    property var specialKeys: []  // Ctrl, Shift, Alt, Meta
    property var regularKeys: []  // Other keys

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
    property var unseenShortcuts: {
        var result = []
        for (var i = 0; i < shortcuts.length; i++) {
            var id = "shortcut_" + i
            if (!trainedIds.includes(id) && !learnedIds.includes(id) && !skippedIds.includes(id)) {
                result.push({index: i, shortcut: shortcuts[i], id: id})
            }
        }
        return result
    }

    property var trainedShortcuts: {
        var result = []
        for (var i = 0; i < shortcuts.length; i++) {
            var id = "shortcut_" + i
            if (trainedIds.includes(id)) {
                result.push({index: i, shortcut: shortcuts[i], id: id})
            }
        }
        return result
    }

    property var learnedShortcuts: {
        var result = []
        for (var i = 0; i < shortcuts.length; i++) {
            var id = "shortcut_" + i
            if (learnedIds.includes(id)) {
                result.push({index: i, shortcut: shortcuts[i], id: id})
            }
        }
        return result
    }

    property bool finished: learnedIds.length > 0 && learnedIds.length === shortcuts.length && skippedIds.length === 0

    Component.onCompleted: {
        setNextShortcut()
        keyHandler.forceActiveFocus()
    }

    function setNextShortcut() {
        if (finished) {
            // All done, go back
            stackView.pop()
            return
        }

        // Weighted random selection like Mouseless
        var shortcutSet = []

        // 90% weight for unseen
        if (unseenShortcuts.length > 0) {
            for (var i = 0; i < 90; i++) {
                shortcutSet = shortcutSet.concat(unseenShortcuts)
            }
        }

        // 50% weight for trained
        if (trainedShortcuts.length > 0) {
            for (var j = 0; j < 50; j++) {
                shortcutSet = shortcutSet.concat(trainedShortcuts)
            }
        }

        // 10% weight for learned
        if (learnedShortcuts.length > 0) {
            for (var k = 0; k < 10; k++) {
                shortcutSet = shortcutSet.concat(learnedShortcuts)
            }
        }

        if (shortcutSet.length === 0) {
            stackView.pop()
            return
        }

        // Random selection
        var randomIndex = Math.floor(Math.random() * shortcutSet.length)
        var selected = shortcutSet[randomIndex]

        currentShortcutIndex = selected.index
        currentShortcut = selected.shortcut

        resetState()
    }

    function resetState() {
        pressedKeys = []
        specialKeys = []
        regularKeys = []
        success = false
        showFailed = false
    }

    function addToTrainedIds(id) {
        if (!trainedIds.includes(id)) {
            var temp = trainedIds.slice()
            temp.push(id)
            trainedIds = temp
        }
        // Remove from learned if it was there
        learnedIds = learnedIds.filter(function(lid) { return lid !== id })
    }

    function addToLearnedIds(id) {
        if (!learnedIds.includes(id)) {
            var temp = learnedIds.slice()
            temp.push(id)
            learnedIds = temp
        }
        // Remove from trained if it was there
        trainedIds = trainedIds.filter(function(tid) { return tid !== id })

        // Record to user data
        userDataManager.recordTeachProgress(appdata.id, category.id, id, true)
    }

    function skip() {
        var id = "shortcut_" + currentShortcutIndex
        if (!skippedIds.includes(id)) {
            var temp = skippedIds.slice()
            temp.push(id)
            skippedIds = temp
        }
        setNextShortcut()
    }

    function checkMatch() {
        if (!currentShortcut) return false

        var expected = currentShortcut.keys
        var pressed = specialKeys.concat(regularKeys)

        if (pressed.length !== expected.length) return false

        // Normalize and compare
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

    function normalizeKey(key) {
        if (key === "Ctrl" || key === "Control") return "Ctrl"
        if (key === "up") return "↑"
        if (key === "down") return "↓"
        if (key === "left") return "←"
        if (key === "right") return "→"
        return key.toUpperCase()
    }

    function handleShortcut() {
        if (checkMatch()) {
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
        } else {
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
        }
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

            // Don't process if already showing success/failed animation
            if (success || advanceTimer.running) {
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
            // Update special keys on release
            var newSpecial = []
            if (event.modifiers & Qt.ControlModifier) newSpecial.push("Ctrl")
            if (event.modifiers & Qt.ShiftModifier) newSpecial.push("Shift")
            if (event.modifiers & Qt.AltModifier) newSpecial.push("Alt")
            if (event.modifiers & Qt.MetaModifier) newSpecial.push("Meta")
            specialKeys = newSpecial
            regularKeys = []
            pressedKeys = specialKeys.concat(regularKeys)

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

        // Expected keys to press
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            Repeater {
                model: currentShortcut ? currentShortcut.keys : []

                RowLayout {
                    spacing: 15

                    Rectangle {
                        width: 90
                        height: 90
                        color: {
                            if (success) return "#1a4d1a"
                            var pressed = pressedKeys.map(function(k) { return normalizeKey(k) })
                            var expected = normalizeKey(modelData)
                            return pressed.includes(expected) ? "#2a2a2a" : "#1a1a1a"
                        }
                        radius: 12
                        border.color: {
                            if (success) return "#6fda00"
                            if (showFailed) return "#ff4444"
                            var pressed = pressedKeys.map(function(k) { return normalizeKey(k) })
                            var expected = normalizeKey(modelData)
                            return pressed.includes(expected) ? "#6fda00" : "#333333"
                        }
                        border.width: 2

                        Behavior on color { ColorAnimation { duration: 150 } }
                        Behavior on border.color { ColorAnimation { duration: 150 } }

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 22
                            font.bold: true
                            color: "#ffffff"
                        }
                    }

                    Text {
                        visible: index < (currentShortcut ? currentShortcut.keys.length - 1 : 0)
                        text: "+"
                        font.pixelSize: 28
                        font.bold: true
                        color: "#666666"
                    }
                }
            }
        }

        // Feedback
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 40
            text: {
                if (success) return "✓ Correct!"
                if (showFailed) return "✗ Try Again"
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
    }
}
