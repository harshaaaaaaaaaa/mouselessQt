import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: main
    color: "#000000"
    required property var appsdata
    required property StackView stackView
    property int donecount: 0

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
            Button{
                id: testButton
                text: "Test your learning"
                font { pixelSize: testButton.height/3; bold: true }
                height:parent.height/3
                width:parent.width/10
                anchors{
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                }

                onClicked: stackView.push("Testground.qml", {
                            appsdata:appsdata,
                            stackView: stackView
                        })
              }

              Text {
                  id:keysets
                  text:"KeySets"
                  color:"#969292"
                  font { pixelSize: parent.height/5; bold: true }
                  anchors{
                          left: parent.left
                          bottom: parent.bottom
                          leftMargin: parent.height/10
                          bottomMargin:parent.height/5
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


