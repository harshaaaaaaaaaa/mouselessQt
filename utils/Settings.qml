import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import "../keydata.js" as Fn

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property StackView stackView

    property string statusMessage: ""
    property string statusColor: "#6fda00"

    Connections {
        target: userDataManager
        function onSuccessMessage(message) {
            statusMessage = message
            statusColor = "#6fda00"
            statusTimer.restart()
        }

        function onErrorOccurred(message) {
            statusMessage = message
            statusColor = "#ff4444"
            statusTimer.restart()
        }
    }

    Component.onCompleted: {
        updateStats()
    }

    function updateStats() {
        var s = userDataManager.getOverallStats()
        statsText.text = `Tests: ${s.totalTests} · Score: ${s.totalScore} · Avg: ${(s.averageScore || 0).toFixed(1)}`
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
                text: "Settings"
                font.pixelSize: 28
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
            spacing: 20

            // Status message
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                visible: statusMessage !== ""
                color: "#151515"
                radius: 8
                border.color: statusColor
                border.width: 2

                Text {
                    anchors.centerIn: parent
                    text: statusMessage
                    font.pixelSize: 13
                    color: statusColor
                }

                Timer {
                    id: statusTimer
                    interval: 4000
                    onTriggered: statusMessage = ""
                }
            }

            // User profile card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: "#151515"
                radius: 12
                border.color: "#2a2a2a"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "User Profile"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#6fda00"
                    }

                    RowLayout {
                        spacing: 15

                        Rectangle {
                            width: 50
                            height: 50
                            radius: 25
                            color: "#6fda00"

                            Text {
                                anchors.centerIn: parent
                                text: userDataManager.currentUser.substring(0, 1).toUpperCase()
                                font.pixelSize: 24
                                font.bold: true
                                color: "#000000"
                            }
                        }

                        ColumnLayout {
                            spacing: 5

                            Text {
                                text: userDataManager.currentUser
                                font.pixelSize: 20
                                font.bold: true
                                color: "#ffffff"
                            }

                            Text {
                                id: statsText
                                font.pixelSize: 13
                                color: "#888888"
                            }
                        }
                    }
                }
            }

            // Backup & Restore card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 220
                color: "#151515"
                radius: 12
                border.color: "#2a2a2a"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Backup & Restore"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#6fda00"
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "Save your progress to a backup file or restore from a previous backup."
                        font.pixelSize: 13
                        color: "#cccccc"
                        wrapMode: Text.WordWrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50

                            background: Rectangle {
                                color: parent.hovered ? "#7fea10" : "#6fda00"
                                radius: 8
                            }

                            contentItem: ColumnLayout {
                                spacing: 2

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "💾"
                                    font.pixelSize: 16
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "Create Backup"
                                    font.pixelSize: 12
                                    font.bold: true
                                    color: "#000000"
                                }
                            }

                            onClicked: saveFileDialog.open()
                        }

                        Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50

                            background: Rectangle {
                                color: parent.hovered ? "#ff9933" : "#ff8800"
                                radius: 8
                            }

                            contentItem: ColumnLayout {
                                spacing: 2

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "📥"
                                    font.pixelSize: 16
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: "Restore Backup"
                                    font.pixelSize: 12
                                    font.bold: true
                                    color: "#000000"
                                }
                            }

                            onClicked: openFileDialog.open()
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: `Default location:\n${userDataManager.getDefaultBackupPath()}`
                        font.pixelSize: 10
                        color: "#666666"
                        wrapMode: Text.Wrap
                        elide: Text.ElideMiddle
                    }
                }
            }

            // Account actions card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 130
                color: "#151515"
                radius: 12
                border.color: "#2a2a2a"
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Account"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#6fda00"
                    }

                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45

                        background: Rectangle {
                            color: parent.hovered ? "#ff5555" : "#ff4444"
                            radius: 8
                        }

                        contentItem: Text {
                            text: "🚪 Logout"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: logoutDialog.open()
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    // File dialogs
    FileDialog {
        id: saveFileDialog
        fileMode: FileDialog.SaveFile
        nameFilters: ["JSON files (*.json)"]
        currentFolder: "file://" + userDataManager.getDefaultBackupPath().substring(0,
            userDataManager.getDefaultBackupPath().lastIndexOf('/'))
        currentFile: "file://" + userDataManager.getDefaultBackupPath()

        onAccepted: {
            var path = selectedFile.toString().replace("file://", "")
            userDataManager.createBackup(path)
        }
    }

    FileDialog {
        id: openFileDialog
        fileMode: FileDialog.OpenFile
        nameFilters: ["JSON files (*.json)"]
        currentFolder: "file://" + userDataManager.getDefaultBackupPath().substring(0,
            userDataManager.getDefaultBackupPath().lastIndexOf('/'))

        onAccepted: {
            var path = selectedFile.toString().replace("file://", "")
            restoreDialog.backupPath = path
            restoreDialog.open()
        }
    }

    // Logout dialog
    Dialog {
        id: logoutDialog
        anchors.centerIn: parent
        width: 350
        height: 180
        modal: true

        background: Rectangle {
            color: "#1a1a1a"
            radius: 12
            border.color: "#ff4444"
            border.width: 2
        }

        header: Item {
            height: 50

            Text {
                anchors.centerIn: parent
                text: "Confirm Logout"
                font.pixelSize: 18
                font.bold: true
                color: "#ffffff"
            }
        }

        contentItem: Text {
            text: "Are you sure you want to logout?\n\nAny unsaved progress will be kept."
            font.pixelSize: 13
            color: "#cccccc"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        footer: RowLayout {
            spacing: 10

            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#353535" : "#2a2a2a"
                    radius: 8
                }

                contentItem: Text {
                    text: "Cancel"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: logoutDialog.close()
            }

            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#ff5555" : "#ff4444"
                    radius: 8
                }

                contentItem: Text {
                    text: "Logout"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    userDataManager.setCurrentUser("")
                    stackView.clear()
                    stackView.push("../UserManager.qml", {
                        appsdata: Fn.appsdata,
                        stackView: stackView
                    })
                    logoutDialog.close()
                }
            }
        }
    }

    // Restore confirmation dialog
    Dialog {
        id: restoreDialog
        anchors.centerIn: parent
        width: 350
        height: 200
        modal: true

        property string backupPath: ""

        background: Rectangle {
            color: "#1a1a1a"
            radius: 12
            border.color: "#ff8800"
            border.width: 2
        }

        header: Item {
            height: 50

            Text {
                anchors.centerIn: parent
                text: "Confirm Restore"
                font.pixelSize: 18
                font.bold: true
                color: "#ffffff"
            }
        }

        contentItem: Text {
            text: "Restore from this backup?\n\nThis will replace your current user data with the backup."
            font.pixelSize: 13
            color: "#cccccc"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        footer: RowLayout {
            spacing: 10

            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#353535" : "#2a2a2a"
                    radius: 8
                }

                contentItem: Text {
                    text: "Cancel"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: restoreDialog.close()
            }

            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#ff9933" : "#ff8800"
                    radius: 8
                }

                contentItem: Text {
                    text: "Restore"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (userDataManager.restoreBackup(restoreDialog.backupPath)) {
                        updateStats()
                    }
                    restoreDialog.close()
                }
            }
        }
    }
}
