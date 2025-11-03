import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property StackView stackView
    required property var appsdata

    signal userSelected(string alias)

    // Status message
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

        function onAvailableUsersChanged() {
            userListView.model = userDataManager.availableUsers
        }
    }

    Component.onCompleted: {
        userDataManager.refreshUserList()
    }

    // Main content
    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.9
        spacing: 30

        // App title
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "MouselessQt"
            font.pixelSize: 48
            font.bold: true
            color: "#6fda00"
            style: Text.Normal
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Master Keyboard Shortcuts"
            font.pixelSize: 16
            color: "#888888"
        }

        // Status message
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 35
            visible: statusMessage !== ""
            color: "#1a1a1a"
            radius: 8
            border.color: statusColor
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: statusMessage
                font.pixelSize: 13
                color: statusColor
            }

            Timer {
                id: statusTimer
                interval: 3000
                onTriggered: statusMessage = ""
            }
        }

        // Create new user card
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 100
            color: "#151515"
            radius: 12
            border.color: "#2a2a2a"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Text {
                    text: "New User:"
                    font.pixelSize: 15
                    font.bold: true
                    color: "#ffffff"
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    color: "#1a1a1a"
                    radius: 8
                    border.color: newUserInput.activeFocus ? "#6fda00" : "#333333"
                    border.width: 2

                    TextInput {
                        id: newUserInput
                        anchors.fill: parent
                        anchors.margins: 12
                        font.pixelSize: 15
                        color: "#ffffff"
                        clip: true
                        selectByMouse: true
                        verticalAlignment: TextInput.AlignVCenter

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Enter username..."
                            font.pixelSize: 15
                            color: "#555555"
                            visible: !newUserInput.text && !newUserInput.activeFocus
                        }

                        Keys.onReturnPressed: createButton.clicked()
                    }
                }

                Button {
                    id: createButton
                    Layout.preferredWidth: 90
                    Layout.preferredHeight: 45

                    background: Rectangle {
                        color: parent.hovered ? "#7fea10" : "#6fda00"
                        radius: 8
                    }

                    contentItem: Text {
                        text: "Create"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#000000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        if (newUserInput.text.trim() !== "") {
                            if (userDataManager.createUser(newUserInput.text.trim())) {
                                newUserInput.text = ""
                                userDataManager.refreshUserList()
                            }
                        }
                    }
                }
            }
        }

        // Divider
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.6
            height: 1
            color: "#2a2a2a"
        }

        // Existing users header
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Select User"
            font.pixelSize: 20
            font.bold: true
            color: "#ffffff"
        }

        // Users list
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 280
            color: "#151515"
            radius: 12
            border.color: "#2a2a2a"
            border.width: 1

            ListView {
                id: userListView
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                clip: true
                model: userDataManager.availableUsers

                delegate: Rectangle {
                    width: userListView.width - 10
                    height: 75
                    color: mouseArea.containsMouse ? "#252525" : "#1a1a1a"
                    radius: 10
                    border.color: mouseArea.containsMouse ? "#6fda00" : "#333333"
                    border.width: 2

                    property var userData: modelData

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                    Behavior on border.color {
                        ColorAnimation { duration: 150 }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            userDataManager.loadUser(userData.alias)
                            stackView.push("AppsView.qml", {
                                appsdata: appsdata,
                                stackView: stackView
                            })
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 15

                        // User icon
                        Rectangle {
                            Layout.preferredWidth: 45
                            Layout.preferredHeight: 45
                            radius: 22.5
                            color: "#6fda00"

                            Text {
                                anchors.centerIn: parent
                                text: userData.alias.substring(0, 1).toUpperCase()
                                font.pixelSize: 20
                                font.bold: true
                                color: "#000000"
                            }
                        }

                        // User info
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5

                            Text {
                                text: userData.alias
                                font.pixelSize: 18
                                font.bold: true
                                color: "#ffffff"
                            }

                            Text {
                                text: `Tests: ${userData.totalTests} · Score: ${userData.totalScore}`
                                font.pixelSize: 12
                                color: "#888888"
                            }
                        }

                        // Delete button
                        Button {
                            Layout.preferredWidth: 65
                            Layout.preferredHeight: 35

                            background: Rectangle {
                                color: parent.hovered ? "#ff5555" : "#ff4444"
                                radius: 6
                            }

                            contentItem: Text {
                                text: "Delete"
                                font.pixelSize: 11
                                font.bold: true
                                color: "#ffffff"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: {
                                deleteDialog.userToDelete = userData.alias
                                deleteDialog.open()
                            }
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    width: 8
                    contentItem: Rectangle {
                        color: "#6fda00"
                        radius: 4
                    }
                }
            }

            // Empty state
            Text {
                visible: userListView.count === 0
                anchors.centerIn: parent
                text: "No users yet.\nCreate one above to get started!"
                font.pixelSize: 14
                color: "#666666"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    // Delete confirmation dialog
    Dialog {
        id: deleteDialog
        anchors.centerIn: parent
        width: 350
        height: 180
        modal: true

        property string userToDelete: ""

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
                text: "Confirm Delete"
                font.pixelSize: 18
                font.bold: true
                color: "#ffffff"
            }
        }

        contentItem: Text {
            text: `Delete user "${deleteDialog.userToDelete}"?\n\nThis action cannot be undone.`
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

                onClicked: deleteDialog.close()
            }

            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                background: Rectangle {
                    color: parent.hovered ? "#ff5555" : "#ff4444"
                    radius: 8
                }

                contentItem: Text {
                    text: "Delete"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    userDataManager.deleteUser(deleteDialog.userToDelete)
                    userDataManager.refreshUserList()
                    deleteDialog.close()
                }
            }
        }
    }
}
