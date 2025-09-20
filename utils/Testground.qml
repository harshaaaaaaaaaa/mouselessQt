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
        onClicked: stackView.pop()
    }

    Rectangle{
        id: submitButton
        height: 40
        width:70
        radius: 5
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        color:"yellow"
        Text {
            id: sub
            text: "Submit"
            font.bold: true
            font.pixelSize: 14
            color:"black"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("Result.qml", {
                    attemptedKeys:attemptedKeys,
                    appsdata:appsdata,
                    stackView: stackView
                })
            }
        }
    }

    Component.onCompleted: {
        resetSequence()
        keyHandler.forceActiveFocus()
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
            else if (event.key === Qt.Key_Right && currentStep == 0) {
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

