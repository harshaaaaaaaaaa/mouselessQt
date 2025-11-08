import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appdata
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

            Image {
                source: appdata.appicon
                Layout.preferredWidth: 48
                Layout.preferredHeight: 48
                fillMode: Image.PreserveAspectFit
            }

            ColumnLayout {
                spacing: 5

                Text {
                    text: appdata.title
                    font.pixelSize: 24
                    font.bold: true
                    color: "#ffffff"
                }

                Text {
                    text: "Select a category to start learning"
                    font.pixelSize: 13
                    color: "#888888"
                }
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "← Back"
                font.pixelSize: 14
                Layout.preferredHeight: 45
                Layout.preferredWidth: 110

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
        anchors.margins: 0
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            width: Math.min(root.width - 80, 1100)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25

            Item { Layout.preferredHeight: 10 }

            // Description
            Text {
                Layout.fillWidth: true
                text: appdata.description || ""
                font.pixelSize: 14
                color: "#888888"
                wrapMode: Text.WordWrap
                visible: appdata.description
            }

            // Categories
            Repeater {
                model: appdata.sets

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentCol.height + 50
                    color: "#151515"
                    radius: 12
                    border.color: "#2a2a2a"
                    border.width: 1

                    ColumnLayout {
                        id: contentCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 25
                        spacing: 18

                        // Category header
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 15

                            Text {
                                text: modelData.title
                                font.pixelSize: 22
                                font.bold: true
                                color: "#ffffff"
                            }

                            Item { Layout.fillWidth: true }

                            Rectangle {
                                Layout.preferredWidth: progressText.width + 20
                                Layout.preferredHeight: 32
                                color: "#1a1a1a"
                                radius: 16
                                border.color: "#333333"
                                border.width: 1

                                Text {
                                    id: progressText
                                    anchors.centerIn: parent
                                    text: {
                                        var progress = userDataManager.getCategoryProgress(appdata.id, modelData.id)
                                        var completed = (progress.completed || []).length
                                        var total = modelData.shortcuts.length
                                        return completed + "/" + total + " learned"
                                    }
                                    font.pixelSize: 13
                                    font.bold: true
                                    color: "#6fda00"
                                }
                            }
                        }

                        // Progress bar
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 10
                            color: "#252525"
                            radius: 5

                            Rectangle {
                                width: {
                                    var progress = userDataManager.getCategoryProgress(appdata.id, modelData.id)
                                    var completed = (progress.completed || []).length
                                    var total = modelData.shortcuts.length
                                    return total > 0 ? (completed / total) * parent.width : 0
                                }
                                height: parent.height
                                color: "#6fda00"
                                radius: 5

                                Behavior on width {
                                    NumberAnimation { duration: 300 }
                                }
                            }
                        }

                        // Shortcuts count
                        Text {
                            text: modelData.shortcuts.length + " shortcuts"
                            font.pixelSize: 13
                            color: "#666666"
                        }

                        // Action buttons
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.topMargin: 5
                            spacing: 15

                            Button {
                                text: "🎓 Teach Mode"
                                font.pixelSize: 15
                                font.bold: true
                                Layout.fillWidth: true
                                Layout.preferredHeight: 55

                                background: Rectangle {
                                    color: parent.hovered ? "#7fea10" : "#6fda00"
                                    radius: 10
                                }

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    color: "#000000"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: {
                                    stackView.push("TeachMode.qml", {
                                        appdata: appdata,
                                        category: modelData,
                                        stackView: stackView
                                    })
                                }
                            }

                            Button {
                                text: "📝 Test Mode"
                                font.pixelSize: 15
                                font.bold: true
                                Layout.fillWidth: true
                                Layout.preferredHeight: 55

                                background: Rectangle {
                                    color: parent.hovered ? "#555555" : "#444444"
                                    radius: 10
                                }

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    color: "#ffffff"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: {
                                    stackView.push("TestMode.qml", {
                                        appdata: appdata,
                                        category: modelData,
                                        stackView: stackView
                                    })
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 30 }
        }
    }
}
