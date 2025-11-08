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
        height: 70
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Image {
                source: appdata.appicon
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: appdata.title + " - Select Category"
                font.pixelSize: 24
                font.bold: true
                color: "#6fda00"
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "← Back"
                font.pixelSize: 14
                Layout.preferredHeight: 40
                Layout.preferredWidth: 100

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
                width: Math.min(parent.width - 40, 1000)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                // Description
                Text {
                    Layout.fillWidth: true
                    Layout.topMargin: 20
                    text: appdata.description || ""
                    font.pixelSize: 13
                    color: "#888888"
                    wrapMode: Text.WordWrap
                }

                // Categories list
                Repeater {
                    model: appdata.sets

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: categoryLayout.height + 40
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            id: categoryLayout
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15

                            // Category header
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 15

                                Text {
                                    text: modelData.title
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#ffffff"
                                }

                                Item { Layout.fillWidth: true }

                                // Progress
                                Text {
                                    text: {
                                        var progress = userDataManager.getCategoryProgress(appdata.id, modelData.id)
                                        var completed = (progress.completed || []).length
                                        var total = modelData.shortcuts.length
                                        return completed + "/" + total + " learned"
                                    }
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: "#6fda00"
                                }
                            }

                            // Progress bar
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 8
                                color: "#252525"
                                radius: 4

                                Rectangle {
                                    width: {
                                        var progress = userDataManager.getCategoryProgress(appdata.id, modelData.id)
                                        var completed = (progress.completed || []).length
                                        var total = modelData.shortcuts.length
                                        return total > 0 ? (completed / total) * parent.width : 0
                                    }
                                    height: parent.height
                                    color: "#6fda00"
                                    radius: 4
                                }
                            }

                            // Shortcuts count
                            Text {
                                text: modelData.shortcuts.length + " shortcuts in this category"
                                font.pixelSize: 12
                                color: "#666666"
                            }

                            // Action buttons
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 15

                                Button {
                                    text: "🎓 Teach Mode"
                                    font.pixelSize: 14
                                    font.bold: true
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50

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
                                        stackView.push("TeachMode.qml", {
                                            appdata: appdata,
                                            category: modelData,
                                            stackView: stackView
                                        })
                                    }
                                }

                                Button {
                                    text: "📝 Test Mode"
                                    font.pixelSize: 14
                                    font.bold: true
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50

                                    background: Rectangle {
                                        color: parent.hovered ? "#555555" : "#444444"
                                        radius: 8
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

                // Bottom spacing
                Item { Layout.preferredHeight: 40 }
            }
        }
    }
}
