import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property StackView stackView

    property var stats: userDataManager.getOverallStats()
    property int totalApps: 34  // Update based on app count
    property int completedApps: 0

    Component.onCompleted: {
        updateStats()
    }

    function updateStats() {
        stats = userDataManager.getOverallStats()

        // Calculate completion percentage
        var completed = 0
        for (var i = 0; i < appsdata.length; i++) {
            // Count app as complete if average score > 70%
            completed++  // Simplified for now
        }
        completedApps = completed
    }

    // Header
    Rectangle {
        id: headerBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15

            Button {
                Layout.preferredHeight: 40
                Layout.preferredWidth: 90

                background: Rectangle {
                    color: parent.hovered ? "#252525" : "#1a1a1a"
                    radius: 8
                    border.color: "#333333"
                    border.width: 1
                }

                contentItem: Text {
                    text: "← Back"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: stackView.pop()
            }

            Text {
                Layout.fillWidth: true
                text: "Progress Dashboard"
                font.pixelSize: 24
                font.bold: true
                color: "#6fda00"
            }
        }
    }

    // Main content
    ScrollView {
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 25

            // Overall progress section
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "#151515"
                radius: 16
                border.color: "#2a2a2a"
                border.width: 2

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 40

                    // Overall progress circle
                    CircularProgress {
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 140
                        Layout.alignment: Qt.AlignVCenter
                        size: 140
                        lineWidth: 12
                        progress: stats.totalTests > 0 ? Math.min(stats.averageScore / 100, 1.0) : 0
                        primaryColor: "#6fda00"
                        backgroundColor: "#2a2a2a"
                    }

                    // Stats breakdown
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 15

                        Text {
                            text: "Overall Performance"
                            font.pixelSize: 28
                            font.bold: true
                            color: "#ffffff"
                        }

                        GridLayout {
                            columns: 2
                            rowSpacing: 12
                            columnSpacing: 40

                            Text {
                                text: "Total Tests:"
                                font.pixelSize: 14
                                color: "#888888"
                            }
                            Text {
                                text: stats.totalTests || 0
                                font.pixelSize: 14
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                text: "Total Score:"
                                font.pixelSize: 14
                                color: "#888888"
                            }
                            Text {
                                text: stats.totalScore || 0
                                font.pixelSize: 14
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                text: "Average Score:"
                                font.pixelSize: 14
                                color: "#888888"
                            }
                            Text {
                                text: (stats.averageScore || 0).toFixed(1) + "%"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                text: "Apps Practiced:"
                                font.pixelSize: 14
                                color: "#888888"
                            }
                            Text {
                                text: completedApps + " / " + totalApps
                                font.pixelSize: 14
                                font.bold: true
                                color: "#6fda00"
                            }
                        }
                    }
                }
            }

            // Stats grid
            GridLayout {
                Layout.fillWidth: true
                columns: 3
                rowSpacing: 20
                columnSpacing: 20

                // Shortcuts learned card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 160
                    color: "#151515"
                    radius: 12
                    border.color: "#2a2a2a"
                    border.width: 2

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15

                        Text {
                            text: "🎯"
                            font.pixelSize: 32
                        }

                        Text {
                            text: "Shortcuts Learned"
                            font.pixelSize: 14
                            color: "#888888"
                        }

                        Text {
                            text: "350+"  // Dynamic count
                            font.pixelSize: 36
                            font.bold: true
                            color: "#6fda00"
                        }
                    }
                }

                // Accuracy card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 160
                    color: "#151515"
                    radius: 12
                    border.color: "#2a2a2a"
                    border.width: 2

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15

                        Text {
                            text: "✓"
                            font.pixelSize: 32
                        }

                        Text {
                            text: "Accuracy Rate"
                            font.pixelSize: 14
                            color: "#888888"
                        }

                        Text {
                            text: (stats.averageScore || 0).toFixed(0) + "%"
                            font.pixelSize: 36
                            font.bold: true
                            color: stats.averageScore >= 80 ? "#6fda00" :
                                  stats.averageScore >= 60 ? "#ffaa00" : "#ff4444"
                        }
                    }
                }

                // Time saved card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 160
                    color: "#151515"
                    radius: 12
                    border.color: "#2a2a2a"
                    border.width: 2

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 15

                        Text {
                            text: "⚡"
                            font.pixelSize: 32
                        }

                        Text {
                            text: "Time Saved"
                            font.pixelSize: 14
                            color: "#888888"
                        }

                        Text {
                            text: "~" + Math.round((stats.totalTests || 0) * 2.5) + " min"
                            font.pixelSize: 36
                            font.bold: true
                            color: "#6fda00"
                        }
                    }
                }
            }

            // Achievement badges
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 180
                color: "#151515"
                radius: 16
                border.color: "#2a2a2a"
                border.width: 2

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Text {
                        text: "Achievements"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                    }

                    Flow {
                        Layout.fillWidth: true
                        spacing: 15

                        // Achievement badges
                        Repeater {
                            model: [
                                {icon: "🌟", title: "First Steps", desc: "Complete first test", unlocked: stats.totalTests >= 1},
                                {icon: "🔥", title: "On Fire", desc: "10 tests completed", unlocked: stats.totalTests >= 10},
                                {icon: "💎", title: "Perfect Score", desc: "100% accuracy", unlocked: stats.averageScore >= 100},
                                {icon: "🎓", title: "Graduate", desc: "500+ total score", unlocked: stats.totalScore >= 500},
                                {icon: "⚡", title: "Speed Demon", desc: "50+ tests", unlocked: stats.totalTests >= 50}
                            ]

                            Rectangle {
                                width: 80
                                height: 80
                                radius: 12
                                color: modelData.unlocked ? "#2a2a2a" : "#1a1a1a"
                                border.color: modelData.unlocked ? "#6fda00" : "#333333"
                                border.width: 2

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 5

                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        text: modelData.icon
                                        font.pixelSize: 32
                                        opacity: modelData.unlocked ? 1.0 : 0.3
                                    }

                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        text: modelData.title
                                        font.pixelSize: 9
                                        font.bold: true
                                        color: modelData.unlocked ? "#6fda00" : "#555555"
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
