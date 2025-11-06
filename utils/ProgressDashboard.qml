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
        // Calculate completion percentage - simplified
        completedApps = stats.totalTests > 0 ? Math.min(stats.totalTests, totalApps) : 0
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

    // Main content with responsive layout
    ScrollView {
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true

        Flickable {
            contentWidth: parent.width
            contentHeight: contentColumn.height

            ColumnLayout {
                id: contentColumn
                width: Math.min(parent.width - 40, 1200)  // Max width with margins
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 25

                Item { height: 10 }

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

                // Stats cards - using Flow for responsive layout
                Flow {
                    Layout.fillWidth: true
                    spacing: 20

                    // Shortcuts learned card
                    Rectangle {
                        width: Math.max(180, (contentColumn.width - 40) / 3)
                        height: 160
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
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: stats.totalTests * 5 || 0  // Estimate 5 shortcuts per test
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Shortcuts Learned"
                                font.pixelSize: 12
                                color: "#888888"
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    // Accuracy rate card
                    Rectangle {
                        width: Math.max(180, (contentColumn.width - 40) / 3)
                        height: 160
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
                                Layout.alignment: Qt.AlignHCenter
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: (stats.averageScore || 0).toFixed(0) + "%"
                                font.pixelSize: 36
                                font.bold: true
                                color: stats.averageScore >= 80 ? "#6fda00" :
                                       stats.averageScore >= 60 ? "#ffaa00" : "#ff4444"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Accuracy Rate"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }

                    // Time saved card
                    Rectangle {
                        width: Math.max(180, (contentColumn.width - 40) / 3)
                        height: 160
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
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: (stats.totalTests * 2 || 0) + "m"  // Estimate 2 min saved per test
                                font.pixelSize: 36
                                font.bold: true
                                color: "#6fda00"
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Time Saved"
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }
                    }
                }

                // Achievements section
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height + 40
                    color: "#151515"
                    radius: 16
                    border.color: "#2a2a2a"
                    border.width: 2

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 30
                        spacing: 20

                        Text {
                            text: "🏆 Achievements"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#ffffff"
                        }

                        Flow {
                            Layout.fillWidth: true
                            spacing: 15

                            // Achievement badges
                            Repeater {
                                model: [
                                    { icon: "🌟", title: "First Steps", desc: "Complete first test", unlocked: stats.totalTests >= 1 },
                                    { icon: "🔥", title: "On Fire", desc: "10 tests completed", unlocked: stats.totalTests >= 10 },
                                    { icon: "💎", title: "Perfect Score", desc: "100% accuracy", unlocked: stats.averageScore >= 100 },
                                    { icon: "🎓", title: "Graduate", desc: "500+ total score", unlocked: stats.totalScore >= 500 },
                                    { icon: "⚡", title: "Speed Demon", desc: "50+ tests", unlocked: stats.totalTests >= 50 }
                                ]

                                Rectangle {
                                    width: 100
                                    height: 120
                                    radius: 12
                                    color: modelData.unlocked ? "#2a2a2a" : "#1a1a1a"
                                    border.color: modelData.unlocked ? "#6fda00" : "#333333"
                                    border.width: 2
                                    opacity: modelData.unlocked ? 1.0 : 0.5

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 10
                                        spacing: 8

                                        Text {
                                            Layout.alignment: Qt.AlignHCenter
                                            text: modelData.icon
                                            font.pixelSize: 36
                                        }

                                        Text {
                                            Layout.alignment: Qt.AlignHCenter
                                            Layout.fillWidth: true
                                            text: modelData.title
                                            font.pixelSize: 10
                                            font.bold: true
                                            color: modelData.unlocked ? "#6fda00" : "#666666"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                        }

                                        Text {
                                            Layout.alignment: Qt.AlignHCenter
                                            Layout.fillWidth: true
                                            text: modelData.desc
                                            font.pixelSize: 8
                                            color: "#888888"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                        }
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
}
