import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page{

    anchors.fill: parent

    required property var appsdata
    required property StackView stackView

    background: Rectangle {
        color: "black"
    }

    property int currentIndex: 0
    property var activeKeys: ({})
    property var expectedSequence: []
    property int currentStep: 0
    property var keyColors: []
    property var keyText: []
    property int count: 1
    property bool skipright: true

    property var attemptedKeys: Array.from({"length": appsdata.test.length}, () =>({"keypressed":[], "color":[],"attempt": false,"correct": false}))

    // attemptedKey array structure below, this data i osed in result.qml , KeyAnalysis.qml
      /* attemptedKeys: {
           "keypresseds":[],  // user key pressed sequence
           "color":[],        // store key color right:greeen , wrong:red
           "attempt":false,  // user attempt key sequence or not
           "correct":false   // whole keysequence right or wrong
       } */

    Button {
        id: backButton
        text: "Back"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: {
            saveSession()
            stackView.pop()
        }
    }

    // Help button
    property bool showHelp: false

    Rectangle {
        id: helpButton
        height: 30
        width: 30
        radius: 15
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 15
        color: mouseAreaHelp.containsMouse ? "#7cfc00" : "#555555"
        border.color: "#7cfc00"
        border.width: 2
        z: 100

        Text {
            text: "?"
            font.bold: true
            font.pixelSize: 16
            color: "white"
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseAreaHelp
            anchors.fill: parent
            hoverEnabled: true
            onClicked: showHelp = !showHelp
        }
    }

    // Help overlay
    Rectangle {
        id: helpOverlay
        anchors.fill: parent
        color: "#dd000000"
        visible: showHelp
        z: 1000

        MouseArea {
            anchors.fill: parent
            onClicked: showHelp = false
        }

        Rectangle {
            width: Math.min(parent.width * 0.8, 500)
            height: Math.min(parent.height * 0.8, 500)
            anchors.centerIn: parent
            color: "#1a1a1a"
            radius: 10
            border.color: "#7cfc00"
            border.width: 2

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: "⌨️ Keyboard Shortcuts"
                    font.pixelSize: 22
                    font.bold: true
                    color: "#7cfc00"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle { width: parent.width; height: 1; color: "#333333" }

                Text {
                    text: "Navigation (when idle):"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffaa00"
                }
                Text {
                    text: "  ← → Arrow keys - Previous/Next"
                    font.pixelSize: 13
                    color: "#cccccc"
                }
                Text {
                    text: "  Alt+← Alt+→ - Safer navigation"
                    font.pixelSize: 13
                    color: "#cccccc"
                }
                Text {
                    text: "  Alt+↓ - Skip question"
                    font.pixelSize: 13
                    color: "#cccccc"
                }

                Rectangle { width: parent.width; height: 1; color: "#222222" }

                Text {
                    text: "Exit & Save:"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffaa00"
                }
                Text {
                    text: "  Ctrl+Esc - Save & exit"
                    font.pixelSize: 13
                    color: "#cccccc"
                }

                Rectangle { width: parent.width; height: 1; color: "#222222" }

                Text {
                    text: "Testing:"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffaa00"
                }
                Text {
                    text: "  🟢 Green - Correct key"
                    font.pixelSize: 13
                    color: "#cccccc"
                }
                Text {
                    text: "  🔴 Red - Wrong key"
                    font.pixelSize: 13
                    color: "#cccccc"
                }
                Text {
                    text: "  Release early to retry"
                    font.pixelSize: 13
                    color: "#cccccc"
                }

                Item { Layout.fillHeight: true }

                Button {
                    text: "Close"
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 35
                    onClicked: showHelp = false

                    background: Rectangle {
                        color: parent.pressed ? "#5fb800" : "#7cfc00"
                        radius: 5
                    }

                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 14
                        font.bold: true
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    // Navigation buttons row
    Row {
        id: navigationButtons
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10
        spacing: 10

        Rectangle {
            id: prevButton
            height: 40
            width: 90
            radius: 5
            color: mouseAreaPrev.containsMouse ? "#555555" : "#333333"
            border.color: "#666666"
            border.width: 1

            Text {
                text: "◀ Previous"
                font.bold: true
                font.pixelSize: 12
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseAreaPrev
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (currentStep === 0) {
                        skipLeft()
                    }
                }
            }
        }

        Rectangle {
            id: skipButton
            height: 40
            width: 70
            radius: 5
            color: mouseAreaSkip.containsMouse ? "#666600" : "#999933"
            border.color: "#aaaa44"
            border.width: 1

            Text {
                text: "Skip ⤵"
                font.bold: true
                font.pixelSize: 12
                color: "black"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseAreaSkip
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (currentStep === 0) {
                        skipRight()
                    }
                }
            }
        }

        Rectangle {
            id: nextButton
            height: 40
            width: 90
            radius: 5
            color: mouseAreaNext.containsMouse ? "#555555" : "#333333"
            border.color: "#666666"
            border.width: 1

            Text {
                text: "Next ▶"
                font.bold: true
                font.pixelSize: 12
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseAreaNext
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (currentStep === 0) {
                        skipRight()
                    }
                }
            }
        }
    }

    Rectangle{
        id: submitButton
        height: 40
        width:70
        radius: 5
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        color: mouseAreaSubmit.containsMouse ? "#ffff00" : "#dddd00"
        border.color: "#ffff66"
        border.width: 1

        Text {
            id: sub
            text: "Submit"
            font.bold: true
            font.pixelSize: 14
            color:"black"
            anchors.centerIn: parent
        }
        MouseArea {
            id: mouseAreaSubmit
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                saveSession()  // Save before submitting
                stackView.push("Result.qml", {
                    attemptedKeys:attemptedKeys,
                    appsdata:appsdata,
                    stackView: stackView
                })
            }
        }
    }

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
                    // Restore attempted keys
                    for (var i = 0; i < session.attemptedKeys.length && i < attemptedKeys.length; i++) {
                        attemptedKeys[i] = session.attemptedKeys[i]
                    }
                }
            }
        }
    }

    function saveSession() {
        if (userDataManager.currentUser !== "") {
            // Save current session state
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
        keyText = new Array(appsdata.test[currentIndex].keys.length).fill("")
    }

    function keyEventToString(event) {
        var key = event.key

        // Handle special keys
        switch (key) {
        case Qt.Key_Control:
            return "Ctrl"
        case Qt.Key_Alt:
            return "Alt"
        case Qt.Key_Shift:
            return "Shift"
        case Qt.Key_Meta:
            return "Meta"
        case Qt.Key_Return:
            return "Enter"
        case Qt.Key_Space:
            return "Space"
        case Qt.Key_Tab:
            return "Tab"
        case Qt.Key_Backtab:
            return "Backtab"
        case Qt.Key_Backspace:
            return "Backspace"
        case Qt.Key_Delete:
            return "Delete"
        case Qt.Key_Insert:
            return "Insert"
        case Qt.Key_Home:
            return "Home"
        case Qt.Key_End:
            return "End"
        case Qt.Key_PageUp:
            return "PageUp"
        case Qt.Key_PageDown:
            return "PageDown"
        case Qt.Key_Up:
            return "Up"
        case Qt.Key_Down:
            return "Down"
        case Qt.Key_Left:
            return "Left"
        case Qt.Key_Right:
            return "Right"
        case Qt.Key_F1:
            return "F1"
        case Qt.Key_F2:
            return "F2"
        case Qt.Key_F3:
            return "F3"
        case Qt.Key_F4:
            return "F4"
        case Qt.Key_F5:
            return "F5"
        case Qt.Key_F6:
            return "F6"
        case Qt.Key_F7:
            return "F7"
        case Qt.Key_F8:
            return "F8"
        case Qt.Key_F9:
            return "F9"
        case Qt.Key_F10:
            return "F10"
        case Qt.Key_F11:
            return "F11"
        case Qt.Key_F12:
            return "F12"
        }

        // Handle alphanumeric characters
        if (key >= Qt.Key_A && key <= Qt.Key_Z) {
            return String.fromCharCode('A'.charCodeAt(0) + (key - Qt.Key_A))
        }
        if (key >= Qt.Key_0 && key <= Qt.Key_9) {
            return String.fromCharCode('0'.charCodeAt(0) + (key - Qt.Key_0))
        }

        return event.text !== ""
                && event.text !== '\x00' ? event.text : "Unknown"
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
        }else if (currentKey === "PageDown") {
            keyMatch = event.key === Qt.Key_PageDown
        }else if (currentKey === "PageUp") {
            keyMatch = event.key === Qt.Key_PageUp
        }else if (currentKey === "Space") {
            keyMatch = event.key === Qt.Key_Space
        }else if (currentKey === "Tab") {
            keyMatch = event.key === Qt.Qt.Key_Tab
        }else if (currentKey === "Backtab") {
            keyMatch = event.key === Qt.Key_Backtab
        }else if (currentKey === "Backspace") {
            keyMatch = event.key === Qt.Key_Backspace
        }else if (currentKey === "Delete") {
            keyMatch = event.key === Qt.Key_Delete
        }else if (currentKey === "Inser") {
            keyMatch = event.key === Qt.Key_Insert
        }else if (currentKey === "Home") {
            keyMatch = event.key === Qt.Key_Home
        }else if (currentKey === "End") {
            keyMatch = event.key === Qt.Key_End
        }else if (currentKey === "Up") {
            keyMatch = event.key === Qt.Key_Up
        }else if (currentKey === "Down") {
            keyMatch = event.key === Qt.Key_Down
        }else if (currentKey === "F1") {
            keyMatch = event.key === Qt.Key_F1
        }else if (currentKey === "F2") {
            keyMatch = event.key === Qt.Key_F2
        }else if (currentKey === "F3") {
            keyMatch = event.key === Qt.Key_F3
        }else if (currentKey === "F4") {
            keyMatch = event.key === Qt.Key_F4
        }else if (currentKey === "F5") {
            keyMatch = event.key === Qt.Key_F5
        }else if (currentKey === "F6") {
            keyMatch = event.key === Qt.Key_F6
        }else if (currentKey === "F7") {
            keyMatch = event.key === Qt.Key_F7
        }else if (currentKey === "F8") {
            keyMatch = event.key === Qt.Key_F8
        }else if (currentKey === "F9") {
            keyMatch = event.key === Qt.Key_F9
        }else if (currentKey === "F10") {
            keyMatch = event.key === Qt.Key_F10
        }else if (currentKey === "F11") {
            keyMatch = event.key === Qt.Key_F11
        }else if (currentKey === "F12") {
            keyMatch = event.key === Qt.Key_F12
        }else {
            keyMatch = event.key === currentKey.charCodeAt(0)
        }

        return keyMatch && !activeKeys[currentKey]
    }

    Rectangle {
        id: keyHandler
        anchors.fill: parent
        focus: true
        color: "transparent"
        Keys.enabled: true

        Keys.onPressed: {

            if (event.isAutoRepeat)
                return

            // Ctrl+Esc to exit testground
            if ((event.modifiers & Qt.ControlModifier) && event.key === Qt.Key_Escape) {
                saveSession()
                stackView.pop()
                event.accepted = true
                return
            }

            // Navigation only when not in middle of entering shortcut
            if (currentStep == 0) {
                // Alt+Right for next question (avoid conflict with shortcuts)
                if ((event.modifiers & Qt.AltModifier) && event.key === Qt.Key_Right) {
                    skipRight()
                    event.accepted = true
                    return
                }
                // Alt+Left for previous question
                else if ((event.modifiers & Qt.AltModifier) && event.key === Qt.Key_Left) {
                    skipLeft()
                    event.accepted = true
                    return
                }
                // Alt+Down to skip current question
                else if ((event.modifiers & Qt.AltModifier) && event.key === Qt.Key_Down) {
                    skipRight()
                    event.accepted = true
                    return
                }
            }

            // Original arrow key navigation (kept for compatibility)
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

                    attemptedKeys[currentIndex].keypressed= keyText
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

            if ((event.key === Qt.Key_Right || event.key === Qt.Key_Left)
                    && currentStep == 0) {
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

        Rectangle {
            id: countstore
            height: 50
            width: 50
            color: "black"

            anchors {
                right: parent.right
                top: parent.top
                rightMargin: 40
                topMargin: 40
            }

            Text {
                id: text
                font.pointSize: 18
                anchors.centerIn: parent
                text: `${count}/${appsdata.test.length}`
                color: "white"
            }
        }

        Column {
            id: main
            width: parent.width
            height: parent.height
            spacing: 40
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height / 3
            }

            Text {
                id: keydes
                text: appsdata.test[currentIndex].title
                color: attemptedKeys[currentIndex].attempt ? "gray" : "white"
                font {
                    pixelSize: 48
                    bold: true
                }
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 100

                Rectangle {
                    visible: attemptedKeys[currentIndex].attempt
                    color: "green"
                    height: 20
                    width: 50
                    radius: 2
                    anchors {
                        left: parent.right
                        leftMargin: 10
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "Done"
                    }
                }
            }

            Row {
                id:keycol
                spacing: 30
                anchors {
                    horizontalCenter: keydes.horizontalCenter
                    top: keydes.top
                    topMargin: 150
                }

                Repeater {
                    model: appsdata.test[currentIndex].keys
                    delegate: Rectangle {
                        id: keyrect
                        width: keyColors[index] === "green" ? 70 : keyColors[index]=== "red" ? 70 : 60
                        height: keyColors[index]=== "green" ? 50 : keyColors[index] === "red" ? 50 : 40

                        color: keyColors[index] === "green" ? "white" : keyColors[index]=== "red" ? "white" : "black"
                        border.color: keyColors[index]=== "green" ? "white" : keyColors[index]=== "red" ? "white" : "gray"
                        border.width: 2
                        radius: 10

                        Text {
                            anchors.centerIn: parent
                            font.pointSize: 14
                            font.bold: true
                            color: "black"
                            text: keyText[index]
                        }
                    }
                }
            }

            Text {
                id: resultDisplay
                text: ""
                color: "green"
                font.pixelSize: 24
                anchors {
                    right:parent.right
                    top:keycol.bottom
                    topMargin: (parent.height/10)
                    rightMargin: (parent.width/3)
                }
                opacity: 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

    Timer {
        id: nextShortcutTimer
        interval: 1000
        onTriggered: advanceShortcut()
    }

    function skipRight() {
        currentIndex = (currentIndex + 1) < appsdata.test.length ? currentIndex + 1 : appsdata.test.length
        count = (((count + 1) < appsdata.test.length + 1)) ? count + 1 : appsdata.test.length
        resetSequence()
    }

    function skipLeft() {
        currentIndex = (currentIndex - 1) > 0 ? currentIndex - 1 : 0
        count = (count - 1) > 0 ? count - 1 : 1
        resetSequence()
    }

    function advanceShortcut() {
        currentIndex = (currentIndex + 1) % appsdata.test.length
        count = (((count + 1) % (appsdata.test.length + 1)) == 0) ? 1 : count + 1
        resetSequence()
        resultDisplay.opacity = 0
    }

    function showResult(success) {
        resultDisplay.text = "Response Submitted!"
        resultDisplay.opacity = 1
    }
}

