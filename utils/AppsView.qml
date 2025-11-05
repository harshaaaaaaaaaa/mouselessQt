import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appsdata
    required property StackView stackView

    // Header bar
    Rectangle {
        id: headerBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 65
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15

            // User avatar
            Rectangle {
                width: 40
                height: 40
                radius: 20
                color: "#6fda00"

                Text {
                    anchors.centerIn: parent
                    text: userDataManager.currentUser.substring(0, 1).toUpperCase()
                    font.pixelSize: 18
                    font.bold: true
                    color: "#000000"
                }
            }

            Text {
                text: userDataManager.currentUser
                font.pixelSize: 16
                font.bold: true
                color: "#ffffff"
            }

            Item { Layout.fillWidth: true }

            // Lookup button
            Button {
                Layout.preferredWidth: 130
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#6fda00" : "#1a1a1a"
                    radius: 8
                    border.color: "#6fda00"
                    border.width: 1

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                contentItem: Text {
                    text: "📖 Lookup"
                    font.pixelSize: 13
                    font.bold: true
                    color: parent.parent.hovered ? "#000000" : "#6fda00"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                onClicked: {
                    stackView.push("LookupView.qml", {
                        stackView: stackView
                    })
                }
            }

            // Settings button
            Button {
                Layout.preferredWidth: 110
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#252525" : "#1a1a1a"
                    radius: 8
                    border.color: "#6fda00"
                    border.width: 1
                }

                contentItem: Text {
                    text: "⚙ Settings"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#6fda00"
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

    // Main content
    ColumnLayout {
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        spacing: 25

        // Title
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Choose an Application"
            font.pixelSize: 24
            font.bold: true
            color: "#ffffff"
        }

        // Apps grid
        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 2
            rowSpacing: 20
            columnSpacing: 20

            Repeater {
                model: appsdata

                Rectangle {
                    Layout.preferredWidth: 160
                    Layout.preferredHeight: 180
                    color: mouseArea.containsMouse ? "#252525" : "#151515"
                    radius: 16
                    border.color: mouseArea.containsMouse ? "#6fda00" : "#2a2a2a"
                    border.width: 2

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                    Behavior on border.color {
                        ColorAnimation { duration: 150 }
                    }
                    Behavior on scale {
                        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                    }

                    scale: mouseArea.pressed ? 0.95 : 1.0

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            stackView.push("CategoryView.qml", {
                                appsdata: modelData,
                                stackView: stackView
                            })
                        }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 12

                        // App icon
                        Image {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 80
                            source: modelData.appicon
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        // App name
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.fillWidth: true
                            text: modelData.title
                            font.pixelSize: 16
                            font.bold: true
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }

                        // Category badge
                        Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            width: childText.width + 16
                            height: 24
                            radius: 12
                            color: "#1a1a1a"
                            border.color: "#6fda00"
                            border.width: 1

                            Text {
                                id: childText
                                anchors.centerIn: parent
                                text: modelData.category || "App"
                                font.pixelSize: 10
                                font.bold: true
                                color: "#6fda00"
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
