import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Rectangle {
    id: root
    anchors.fill: parent
    color: "#000000"

    required property StackView stackView

    Connections {
        target: userDataManager
        function onSuccessMessage(message) {
            statusText.text = message
            statusText.color = "green"
            statusText.visible = true
            statusTimer.restart()
        }

        function onErrorOccurred(message) {
            statusText.text = message
            statusText.color = "red"
            statusText.visible = true
            statusTimer.restart()
        }
    }

    Component.onCompleted: {
        updateStats()
    }

    property var stats: ({})

    function updateStats() {
        stats = userDataManager.getOverallStats()
        statsColumn.updateDisplay()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            Button {
                text: "< Back"
                font.pixelSize: 16

                background: Rectangle {
                    color: parent.pressed ? "#555555" : "#333333"
                    radius: 5
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: stackView.pop()
            }

            Text {
                text: "Settings & Backup"
                font.pixelSize: 32
                font.bold: true
                color: "#7cfc00"
                Layout.fillWidth: true
            }
        }

        // Status message
        Text {
            id: statusText
            text: ""
            font.pixelSize: 14
            color: "green"
            Layout.fillWidth: true
            visible: false
            wrapMode: Text.WordWrap
        }

        Timer {
            id: statusTimer
            interval: 5000
            onTriggered: statusText.visible = false
        }

        // User info section
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#1a1a1a"
            radius: 10
            border.color: "#333333"
            border.width: 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: "Current User"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#7cfc00"
                }

                Text {
                    text: "Alias: " + userDataManager.currentUser
                    font.pixelSize: 18
                    color: "white"
                }

                ColumnLayout {
                    id: statsColumn
                    spacing: 5

                    function updateDisplay() {
                        var s = userDataManager.getOverallStats()
                        statsText.text = "Total Tests: " + s.totalTests +
                                       " | Total Score: " + s.totalScore +
                                       " | Average: " + (s.averageScore || 0).toFixed(2)
                    }

                    Text {
                        id: statsText
                        font.pixelSize: 14
                        color: "#999999"
                    }

                    Component.onCompleted: updateDisplay()
                }
            }
        }

        // Backup section
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            color: "#1a1a1a"
            radius: 10
            border.color: "#333333"
            border.width: 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "Backup & Restore"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#7cfc00"
                }

                Text {
                    text: "Create a backup of your progress to save all your test results and practice history."
                    font.pixelSize: 14
                    color: "#cccccc"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    Button {
                        text: "Create Backup"
                        font.pixelSize: 16
                        Layout.preferredWidth: 180
                        Layout.preferredHeight: 50

                        background: Rectangle {
                            color: parent.pressed ? "#5fb800" : "#7cfc00"
                            radius: 5
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            saveFileDialog.open()
                        }
                    }

                    Button {
                        text: "Restore Backup"
                        font.pixelSize: 16
                        Layout.preferredWidth: 180
                        Layout.preferredHeight: 50

                        background: Rectangle {
                            color: parent.pressed ? "#cc8800" : "#ffaa00"
                            radius: 5
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            openFileDialog.open()
                        }
                    }
                }

                Text {
                    text: "Default backup location: " + userDataManager.getDefaultBackupPath()
                    font.pixelSize: 11
                    color: "#666666"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
            }
        }

        // Logout section
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#1a1a1a"
            radius: 10
            border.color: "#333333"
            border.width: 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "Account Actions"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#7cfc00"
                }

                Button {
                    text: "Logout"
                    font.pixelSize: 16
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 45

                    background: Rectangle {
                        color: parent.pressed ? "#cc0000" : "#ff3333"
                        radius: 5
                    }

                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        logoutDialog.open()
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
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

    // Logout confirmation dialog
    Dialog {
        id: logoutDialog
        title: "Confirm Logout"
        modal: true
        anchors.centerIn: parent
        width: 400

        background: Rectangle {
            color: "#1a1a1a"
            border.color: "#444444"
            border.width: 2
            radius: 10
        }

        header: Rectangle {
            width: parent.width
            height: 60
            color: "#2a2a2a"
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Confirm Logout"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }
        }

        contentItem: Text {
            text: "Are you sure you want to logout?\nAll unsaved progress will be lost."
            font.pixelSize: 16
            color: "white"
            wrapMode: Text.WordWrap
        }

        standardButtons: Dialog.Yes | Dialog.No

        onAccepted: {
            userDataManager.setCurrentUser("")
            stackView.clear()
            stackView.push("UserManager.qml", {
                appsdata: Fn.appsdata,
                stackView: stackView
            })
        }
    }

    // Restore confirmation dialog
    Dialog {
        id: restoreDialog
        title: "Confirm Restore"
        modal: true
        anchors.centerIn: parent
        width: 450

        property string backupPath: ""

        background: Rectangle {
            color: "#1a1a1a"
            border.color: "#444444"
            border.width: 2
            radius: 10
        }

        header: Rectangle {
            width: parent.width
            height: 60
            color: "#2a2a2a"
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Confirm Restore"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }
        }

        contentItem: Text {
            text: "Are you sure you want to restore from this backup?\nThis will replace your current user data."
            font.pixelSize: 16
            color: "white"
            wrapMode: Text.WordWrap
        }

        standardButtons: Dialog.Yes | Dialog.No

        onAccepted: {
            if (userDataManager.restoreBackup(backupPath)) {
                updateStats()
            }
        }
    }
}
