import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: main
    color: "#000000"
    required property var appsdata
    required property StackView stackView
    property int donecount: 0
    property int learnedCount: calculateLearnedCount()

    function calculateLearnedCount() {
        var total = 0
        if (appsdata.sets) {
            for (var i = 0; i < appsdata.sets.length; i++) {
                total += userDataManager.getLearnedCount(appsdata.id, appsdata.sets[i].id)
            }
        }
        return total
    }

    function refreshLearnedCount() {
        learnedCount = calculateLearnedCount()
    }

    // Refresh learned count when view becomes visible
    onVisibleChanged: {
        if (visible) {
            refreshLearnedCount()
        }
    }

    // Also refresh on component completion
    Component.onCompleted: {
        refreshLearnedCount()
    }

    Button {
        id: backButton
        text: "Back"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: stackView.pop()
    }

    Rectangle {
        id: content
        color: "black"
        width: parent.width / 1.2
        anchors {
            top: backButton.bottom
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: backButton.height/1.2
            bottomMargin: backButton.height
        }

        Rectangle {
            id: logo
            width: parent.width
            height: parent.height/7
            color: "black"

            //logo image
            Image {
                id: applogo
                source: appsdata.appicon
                height:parent.height*0.8
                fillMode: Image.PreserveAspectFit
                anchors{
                    left:parent.left
                    verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id: appname
                text: appsdata.title
                color: "white"
                font { pixelSize: applogo.height/2; bold: true }
                anchors{
                    left:applogo.right
                    leftMargin: applogo.width/10
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Rectangle {
            id: test
            width: parent.width
            height: logo.height/1.2
            color: "#070707"
            radius: 7
            anchors {
                top: logo.bottom
            }

            Text {
                id: keysets
                text: "KeySets"
                color: "#969292"
                font { pixelSize: parent.height/5; bold: true }
                anchors{
                    left: parent.left
                    bottom: parent.bottom
                    leftMargin: parent.height/10
                    bottomMargin: parent.height/5
                }
            }

            // Progressive unlocking indicator
            Text {
                id: unlockProgress
                visible: learnedCount < 20
                text: "🔒 Learn " + learnedCount + "/20 shortcuts to unlock Test Mode"
                color: "#ffaa00"
                font { pixelSize: parent.height/6; bold: true }
                anchors {
                    right: testButton.left
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }
            }

            // Training Mode Button (always available)
            Button {
                id: trainingButton
                visible: learnedCount < 20
                text: "📚 Training Mode"
                font { pixelSize: trainingButton.height/3; bold: true }
                height: parent.height/3
                width: parent.width/10
                anchors{
                    right: parent.right
                    rightMargin: parent.width/10 + 20
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle {
                    color: trainingButton.hovered ? "#4488ff" : "#3377ee"
                    radius: 8
                    border.color: "#5599ff"
                    border.width: 2
                }

                contentItem: Text {
                    text: trainingButton.text
                    font: trainingButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    stackView.push("Testground.qml", {
                        appsdata: appsdata,
                        stackView: stackView,
                        mode: "training"
                    })
                }
            }

            // Test Mode Button (unlocked)
            Button {
                id: testButton
                text: "✓ Test Mode"
                enabled: true
                font { pixelSize: testButton.height/3; bold: true }
                height: parent.height/3
                width: parent.width/10
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle {
                    color: testButton.enabled ? (testButton.hovered ? "#6fda00" : "#5ac300") : "#3a3a3a"
                    radius: 8
                    border.color: testButton.enabled ? "#6fda00" : "#555555"
                    border.width: 2
                }

                contentItem: Text {
                    text: testButton.text
                    font: testButton.font
                    color: testButton.enabled ? "#000000" : "#777777"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (learnedCount >= 20) {
                        stackView.push("Testground.qml", {
                            appsdata: appsdata,
                            stackView: stackView,
                            mode: "test"
                        })
                    }
                }
            }
        }
        Rectangle{
            color:"#070707"
            radius: 7
            anchors {
                top: test.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

        ListView {
            model: appsdata.sets
            spacing: 3
            clip: true
            anchors.fill: parent

            delegate: Rectangle {
                width: parent.width
                height: 60
                color: "#556b4f"
                radius: 10

                Text {
                    text: modelData.title
                    color:"white"
                    font { pixelSize: parent.height/2.5; bold: true }
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                }

                Text {
                    text: `${donecount}/${modelData.shortcuts.length}`
                    color:"#969599"
                    font { pixelSize: parent.height/4; bold: true }
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width/20
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("ShortcutView.qml", {
                            appsdata: modelData,
                            donecount:donecount,
                            stackView: stackView
                        })
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
                width: 8
                contentItem: Rectangle {
                    color: "gray"
                    implicitWidth: 6
                    radius: 3
                }
            }
        }
    }
    }
}


