import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appsdata
    required property StackView stackView

    // Header
    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Text {
                text: "MouselessQt"
                font.pixelSize: 32
                font.bold: true
                color: "#6fda00"
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "Progress Summary"
                font.pixelSize: 14
                font.bold: true
                Layout.preferredHeight: 45
                Layout.preferredWidth: 180

                background: Rectangle {
                    color: parent.hovered ? "#7fea10" : "#6fda00"
                    radius: 8
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    stackView.push("SummaryView.qml", {
                        appsdata: appsdata,
                        stackView: stackView
                    })
                }
            }

            Button {
                text: "Back to Users"
                font.pixelSize: 14
                Layout.preferredHeight: 45
                Layout.preferredWidth: 150

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
        }
    }

    // Main content
    ScrollView {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true

        Flickable {
            contentWidth: parent.width
            contentHeight: contentColumn.height

            ColumnLayout {
                id: contentColumn
                width: Math.min(parent.width - 40, 1400)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 25

                // Title
                Text {
                    Layout.topMargin: 20
                    text: "Choose an Application"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                }

                Text {
                    text: "Select an app to start learning its shortcuts"
                    font.pixelSize: 14
                    color: "#888888"
                    Layout.bottomMargin: 10
                }

                // Apps grid (using Flow for dynamic wrapping)
                Flow {
                    Layout.fillWidth: true
                    spacing: 20

                    Repeater {
                        model: appsdata

                        // App card
                        Rectangle {
                            width: 200
                            height: 220
                            color: mouseArea.containsMouse ? "#1a1a1a" : "#151515"
                            radius: 12
                            border.color: mouseArea.containsMouse ? "#6fda00" : "#2a2a2a"
                            border.width: 2

                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                            Behavior on border.color {
                                ColorAnimation { duration: 150 }
                            }

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    stackView.push("CategoryView.qml", {
                                        appdata: modelData,
                                        stackView: stackView
                                    })
                                }
                            }

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 20
                                spacing: 15

                                // App icon
                                Image {
                                    source: modelData.appicon
                                    Layout.preferredWidth: 64
                                    Layout.preferredHeight: 64
                                    Layout.alignment: Qt.AlignHCenter
                                    fillMode: Image.PreserveAspectFit
                                }

                                // App title
                                Text {
                                    Layout.fillWidth: true
                                    text: modelData.title
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                // Category badge
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredHeight: 24
                                    Layout.preferredWidth: categoryText.width + 16
                                    color: "#252525"
                                    radius: 12

                                    Text {
                                        id: categoryText
                                        anchors.centerIn: parent
                                        text: modelData.category || "General"
                                        font.pixelSize: 11
                                        color: "#888888"
                                    }
                                }

                                // Shortcuts count
                                Text {
                                    Layout.fillWidth: true
                                    text: {
                                        var total = 0
                                        for (var i = 0; i < modelData.sets.length; i++) {
                                            total += modelData.sets[i].shortcuts.length
                                        }
                                        return total + " shortcuts"
                                    }
                                    font.pixelSize: 12
                                    color: "#6fda00"
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }

                // Bottom spacing
                Item { Layout.preferredHeight: 40 }
            }
        }
    }
}
