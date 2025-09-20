import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "#f5f5f5"
    required property var categories
    required property StackView stackView

    ListView {
        anchors.fill: parent
        model: categories
        spacing: 2
        clip: true

        delegate: Rectangle {
            width: parent.width
            height: 60
            color: "#ffffff"

            Text {
                text: modelData.title
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push("Shortcut.qml", {  // Update path
                        categoryData: modelData,
                        stackView: stackView
                    })
                }
            }
        }

        ScrollBar.vertical: ScrollBar {}
    }
}
