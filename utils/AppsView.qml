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
    ScrollView {
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true
        contentWidth: availableWidth

        Flickable {
            contentWidth: parent.width
            contentHeight: contentColumn.height

            ColumnLayout {
                id: contentColumn
                width: Math.min(parent.width - 40, 1400)  // Max width 1400px with margins
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 25

                Item { height: 10 }

                // Stats hero section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#151515"
                    radius: 16
                    border.color: "#2a2a2a"
                    border.width: 2

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 25
                        spacing: 30

                        // Title section
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: "Welcome Back, " + userDataManager.currentUser + "!"
                                font.pixelSize: 26
                                font.bold: true
                                color: "#ffffff"
                            }

                            Text {
                                text: "Master keyboard shortcuts from 34 applications"
                                font.pixelSize: 14
                                color: "#888888"
                            }
                        }

                        // Quick stats
                        RowLayout {
                            spacing: 30

                            // Tests completed
                            ColumnLayout {
                                spacing: 5

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: userDataManager.getOverallStats().totalTests || 0
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#6fda00"
                                }

                                Text {
                                    text: "Tests"
                                    font.pixelSize: 12
                                    color: "#888888"
                                }
                            }

                            Rectangle {
                                width: 1
                                height: 50
                                color: "#333333"
                            }

                            // Average score
                            ColumnLayout {
                                spacing: 5

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: (userDataManager.getOverallStats().averageScore || 0).toFixed(0) + "%"
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#6fda00"
                                }

                                Text {
                                    text: "Accuracy"
                                    font.pixelSize: 12
                                    color: "#888888"
                                }
                            }

                            Rectangle {
                                width: 1
                                height: 50
                                color: "#333333"
                            }

                            // Progress button
                            Button {
                                Layout.preferredWidth: 140
                                Layout.preferredHeight: 50

                                background: Rectangle {
                                    color: parent.hovered ? "#7feb10" : "#6fda00"
                                    radius: 10
                                    border.color: "#7feb10"
                                    border.width: 2

                                    Behavior on color {
                                        ColorAnimation { duration: 150 }
                                    }
                                }

                                contentItem: ColumnLayout {
                                    spacing: 2

                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        text: "📊"
                                        font.pixelSize: 20
                                    }

                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        text: "Dashboard"
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "#000000"
                                    }
                                }

                                onClicked: {
                                    stackView.push("ProgressDashboard.qml", {
                                        stackView: stackView
                                    })
                                }
                            }
                        }
                    }
                }

                // Section header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    Text {
                        text: "Applications"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 2
                        color: "#2a2a2a"
                        radius: 1
                    }

                    Text {
                        text: appsdata.length + " apps"
                        font.pixelSize: 14
                        color: "#888888"
                    }
                }

                // Apps grid - using Flow for responsive layout
                Flow {
                    Layout.fillWidth: true
                    spacing: 20

                    Repeater {
                        model: appsdata

                        Rectangle {
                            width: 180
                            height: 200
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

                Item { Layout.fillHeight: true; Layout.preferredHeight: 20 }
            }
        }
    }
