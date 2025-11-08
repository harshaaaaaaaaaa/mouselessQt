import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property var appsdata
    required property StackView stackView

    Component.onCompleted: {
        refreshStats()
    }

    function refreshStats() {
        // Get all progress data
        var allProgress = userDataManager.getAllProgress()
        var stats = userDataManager.getSummaryStats()

        totalShortcuts = userDataManager.getTotalShortcutsCompleted()
        totalCategories = userDataManager.getTotalCategoriesCompleted()
        overallAccuracy = userDataManager.getOverallAccuracy().toFixed(1)
        totalTests = stats.totalTestsTaken || 0

        // Calculate total available shortcuts
        var totalAvailable = 0
        for (var i = 0; i < appsdata.length; i++) {
            for (var j = 0; j < appsdata[i].sets.length; j++) {
                totalAvailable += appsdata[i].sets[j].shortcuts.length
            }
        }
        totalAvailableShortcuts = totalAvailable
    }

    property int totalShortcuts: 0
    property int totalAvailableShortcuts: 0
    property int totalCategories: 0
    property real overallAccuracy: 0
    property int totalTests: 0

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
                text: "Progress Summary"
                font.pixelSize: 28
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
                width: Math.min(parent.width - 40, 1200)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 25

                // Stats cards
                Flow {
                    Layout.fillWidth: true
                    Layout.topMargin: 20
                    spacing: 20

                    // Shortcuts learned
                    Rectangle {
                        width: Math.max(200, (contentColumn.width - 60) / 4)
                        height: 140
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: totalShortcuts + "/" + totalAvailableShortcuts
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Shortcuts Learned"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }

                    // Categories completed
                    Rectangle {
                        width: Math.max(200, (contentColumn.width - 60) / 4)
                        height: 140
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: totalCategories
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Categories Done"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }

                    // Accuracy
                    Rectangle {
                        width: Math.max(200, (contentColumn.width - 60) / 4)
                        height: 140
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: overallAccuracy + "%"
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Overall Accuracy"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }

                    // Tests taken
                    Rectangle {
                        width: Math.max(200, (contentColumn.width - 60) / 4)
                        height: 140
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: totalTests
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Tests Taken"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }
                }

                // Progress by app
                Text {
                    Layout.topMargin: 20
                    text: "Progress by Application"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#ffffff"
                }

                Repeater {
                    model: appsdata

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: appColumn.height + 40
                        color: "#151515"
                        radius: 12
                        border.color: "#2a2a2a"
                        border.width: 1

                        ColumnLayout {
                            id: appColumn
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15

                            // App header
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 15

                                Image {
                                    source: modelData.appicon
                                    Layout.preferredWidth: 32
                                    Layout.preferredHeight: 32
                                    fillMode: Image.PreserveAspectFit
                                }

                                Text {
                                    text: modelData.title
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }

                                Item { Layout.fillWidth: true }
                            }

                            // Categories progress
                            Repeater {
                                model: modelData.sets

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
                                            text: modelData.title
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#ffffff"
                                        }

                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 8
                                            color: "#252525"
                                            radius: 4

                                            Rectangle {
                                                width: {
                                                    var appProgress = userDataManager.getAppProgress(appsdata[index].id)
                                                    var catProgress = appProgress[modelData.id] || {}
                                                    var completed = (catProgress.completed || []).length
                                                    var total = modelData.shortcuts.length
                                                    return total > 0 ? (completed / total) * parent.width : 0
                                                }
                                                height: parent.height
                                                color: "#6fda00"
                                                radius: 4
                                            }
                                        }

                                        Text {
                                            Layout.preferredWidth: 80
                                            text: {
                                                var appProgress = userDataManager.getAppProgress(appsdata[index].id)
                                                var catProgress = appProgress[modelData.id] || {}
                                                var completed = (catProgress.completed || []).length
                                                var total = modelData.shortcuts.length
                                                return completed + "/" + total
                                            }
                                            font.pixelSize: 13
                                            color: "#6fda00"
                                            horizontalAlignment: Text.AlignRight
                                        }
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
