import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: tool
    anchors.fill: parent
    color: "black"

    required property var appsdata
    required property StackView stackView

        GridLayout {
            id: gridLayout
            columns: 2
             anchors.fill: parent
            anchors{
                left: parent.left
                leftMargin: parent.width/10
            }

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



