import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: tool
    anchors.fill: parent
    color: "black"

    required property var appsdata
    required property StackView stackView

    // Header with user info and settings
    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        color: "#1a1a1a"
        border.color: "#333333"
        border.width: 1

        Row {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 15

            Text {
                text: "User: " + userDataManager.currentUser
                font.pixelSize: 18
                font.bold: true
                color: "#7cfc00"
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                width: parent.width - settingsButton.width - 150
                height: parent.height
            }

            Button {
                id: settingsButton
                text: "⚙ Settings"
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                width: 120
                height: 40

                background: Rectangle {
                    color: parent.pressed ? "#555555" : "#333333"
                    radius: 5
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    stackView.push("Settings.qml", {
                        stackView: stackView
                    })
                }
            }
        }
    }

    GridLayout {
        id: gridLayout
        columns: 2
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.leftMargin: parent.width/10

        Repeater {
            model: appsdata
            delegate: AppDelegate {
                appTitle: modelData.title
                appIcon: modelData.appicon
                Layout.preferredWidth: parent.width/3
                Layout.preferredHeight: parent.height/3
            }
        }
    }

    component AppDelegate: Rectangle {
        id: delegateRoot
        property string appTitle
        property string appIcon

        radius: 20
        border.width: 2
        border.color: "black"
        color: "#808080"

            Image {
                id:pic
                source: delegateRoot.appIcon
                width: parent.width/1.2
                height: parent.height/1.5
                anchors{
                        left: parent.left
                        leftMargin: 2
                        top: parent.top
                        topMargin: 10
                    }
            }

            Text {
                text: delegateRoot.appTitle
                color: "white"
                font { pixelSize: 16; bold: true }
                anchors{
                        top: pic.bottom
                        topMargin: 10
                        left: parent.left
                        leftMargin: 20
                }
            }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("CategoryView.qml", {
                    appsdata: modelData,
                    stackView: stackView
                })
            }
        }
    }
}



