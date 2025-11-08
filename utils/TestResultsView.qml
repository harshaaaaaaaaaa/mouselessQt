import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appdata
    required property var category
    required property int correctCount
    required property int wrongCount
    required property int total
    required property StackView stackView

    property real currentAccuracy: total > 0 ? (correctCount * 100.0 / total) : 0
    property var previousTests: []

    Component.onCompleted: {
        previousTests = userDataManager.getTestHistory(appdata.id, category.id, 3)
    }

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

            Text {
                text: "Test Results"
                font.pixelSize: 28
                font.bold: true
                color: "#6fda00"
            }

            Item { Layout.fillWidth: true }
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
                width: Math.min(parent.width - 40, 800)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30

                // Main result card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.topMargin: 30
                    Layout.preferredHeight: resultColumn.height + 60
                    color: "#151515"
                    radius: 16
                    border.color: currentAccuracy >= 80 ? "#6fda00" : (currentAccuracy >= 60 ? "#ffaa00" : "#ff4444")
                    border.width: 3

                    ColumnLayout {
                        id: resultColumn
                        anchors.centerIn: parent
                        width: parent.width - 60
                        spacing: 25

                        // App and category
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: appdata.title + " - " + category.title
                            font.pixelSize: 20
                            font.bold: true
                            color: "#ffffff"
                        }

                        // Score
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: currentAccuracy.toFixed(1) + "%"
                            font.pixelSize: 72
                            font.bold: true
                            color: currentAccuracy >= 80 ? "#6fda00" : (currentAccuracy >= 60 ? "#ffaa00" : "#ff4444")
                        }

                        // Correct/Wrong breakdown
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 40

                            ColumnLayout {
                                spacing: 5

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: correctCount
                                    font.pixelSize: 36
                                    font.bold: true
                                    color: "#6fda00"
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "Correct"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                            }

                            Rectangle {
                                width: 2
                                height: 60
                                color: "#333333"
                            }

                            ColumnLayout {
                                spacing: 5

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: wrongCount
                                    font.pixelSize: 36
                                    font.bold: true
                                    color: "#ff4444"
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "Wrong"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                            }

                            Rectangle {
                                width: 2
                                height: 60
                                color: "#333333"
                            }

                            ColumnLayout {
                                spacing: 5

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: total
                                    font.pixelSize: 36
                                    font.bold: true
                                    color: "#ffffff"
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "Total"
                                    font.pixelSize: 14
                                    color: "#888888"
                                }
                            }
                        }
                    }
                }

                // Comparison with previous tests
                Text {
                    text: "Previous Tests"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#ffffff"
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: previousColumn.height + 40
                    color: "#151515"
                    radius: 12
                    border.color: "#2a2a2a"
                    border.width: 1
                    visible: previousTests.length > 0

                    ColumnLayout {
                        id: previousColumn
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15

                        Repeater {
                            model: previousTests

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: "#1a1a1a"
                                radius: 8

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 15

                                    Text {
                                        Layout.preferredWidth: 200
                                        text: {
                                            var date = new Date(modelData.date)
                                            return date.toLocaleDateString() + " " + date.toLocaleTimeString()
                                        }
                                        font.pixelSize: 13
                                        color: "#888888"
                                    }

                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 8
                                        color: "#252525"
                                        radius: 4

                                        Rectangle {
                                            width: (modelData.accuracy / 100) * parent.width
                                            height: parent.height
                                            color: modelData.accuracy >= 80 ? "#6fda00" : (modelData.accuracy >= 60 ? "#ffaa00" : "#ff4444")
                                            radius: 4
                                        }
                                    }

                                    Text {
                                        Layout.preferredWidth: 100
                                        text: modelData.accuracy.toFixed(1) + "%"
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: modelData.accuracy >= 80 ? "#6fda00" : (modelData.accuracy >= 60 ? "#ffaa00" : "#ff4444")
                                        horizontalAlignment: Text.AlignRight
                                    }

                                    Text {
                                        Layout.preferredWidth: 100
                                        text: modelData.correct + "/" + modelData.total
                                        font.pixelSize: 13
                                        color: "#666666"
                                        horizontalAlignment: Text.AlignRight
                                    }
                                }
                            }
                        }
                    }
                }

                // No previous tests message
                Text {
                    Layout.fillWidth: true
                    visible: previousTests.length === 0
                    text: "This is your first test in this category!\nKeep practicing to see your progress."
                    font.pixelSize: 14
                    color: "#666666"
                    horizontalAlignment: Text.AlignHCenter
                }

                // Performance message
                Text {
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    text: {
                        if (currentAccuracy >= 90) return "🌟 Excellent! You're mastering these shortcuts!"
                        if (currentAccuracy >= 80) return "👍 Great job! Keep it up!"
                        if (currentAccuracy >= 70) return "💪 Good effort! Practice makes perfect!"
                        if (currentAccuracy >= 60) return "📚 Keep practicing to improve your score!"
                        return "🎯 Don't give up! Try the teach mode again!"
                    }
                    font.pixelSize: 16
                    font.bold: true
                    color: "#6fda00"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                // Action buttons
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 20
                    spacing: 15

                    Button {
                        text: "Practice Again"
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
                            stackView.pop()
                            stackView.push("TeachMode.qml", {
                                appdata: appdata,
                                category: category,
                                stackView: stackView
                            })
                        }
                    }

                    Button {
                        text: "Retake Test"
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
                            stackView.pop()
                            stackView.push("TestMode.qml", {
                                appdata: appdata,
                                category: category,
                                stackView: stackView
                            })
                        }
                    }

                    Button {
                        text: "Back to Categories"
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50

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

                        onClicked: {
                            stackView.pop()
                        }
                    }
                }

                // Bottom spacing
                Item { Layout.preferredHeight: 40 }
            }
        }
    }
}
