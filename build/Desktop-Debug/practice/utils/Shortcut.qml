import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    color: "#f5f5f5"
    required property var category
    required property StackView stackView

    ListView {
        anchors.fill: parent
        model: category.shortcuts
        spacing: 2
        clip: true

        delegate: Rectangle {
            width: parent.width
            height: 60
            color: "#ffffff"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 20

                Text {
                    text: modelData.title
                    font.pixelSize: 14
                    Layout.preferredWidth: 150
                }

                Row {
                    spacing: 5
                    Repeater {
                        model: modelData.keys

                        Rectangle {
                            height: 30
                            width: Math.max(30, keyText.width + 10)
                            color: "#e0e0e0"
                            radius: 3

                            Text {
                                id: keyText
                                text: modelData
                                anchors.centerIn: parent
                                font.pixelSize: 12
                            }
                        }
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {}
    }

    Button {
        text: "Back"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: stackView.pop()
    }
}
