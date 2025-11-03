import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#000000"

    required property StackView stackView
    required property var appsdata

    signal userSelected(string alias)

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

        function onAvailableUsersChanged() {
            userListView.model = userDataManager.availableUsers
        }
    }

    Component.onCompleted: {
        userDataManager.refreshUserList()
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.9
        spacing: 20

        Text {
            text: "MouselessQt"
            font.pixelSize: 48
            font.bold: true
            color: "#7cfc00"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Select or Create User Profile"
            font.pixelSize: 24
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        // Status message
        Text {
            id: statusText
            text: ""
            font.pixelSize: 16
            color: "green"
            Layout.alignment: Qt.AlignHCenter
            visible: false
        }

        Timer {
            id: statusTimer
            interval: 3000
            onTriggered: statusText.visible = false
        }

        // Create new user section
        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 100
            color: "#1a1a1a"
            radius: 10
            border.color: "#333333"
            border.width: 2

            RowLayout {
                anchors.centerIn: parent
                spacing: 15

                Text {
                    text: "New User:"
                    font.pixelSize: 18
                    color: "white"
                }

                Rectangle {
                    width: 250
                    height: 40
                    color: "#2a2a2a"
                    border.color: "#555555"
                    border.width: 1
                    radius: 5

                    TextInput {
                        id: newUserInput
                        anchors.fill: parent
                        anchors.margins: 10
                        font.pixelSize: 16
                        color: "white"
                        clip: true
                        selectByMouse: true

                        Text {
                            text: "Enter alias..."
                            font.pixelSize: 16
                            color: "#666666"
                            visible: !newUserInput.text && !newUserInput.activeFocus
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Button {
                    text: "Create"
                    font.pixelSize: 16
                    font.bold: true

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

        // Existing users list
        Text {
            text: "Existing Users:"
            font.pixelSize: 20
            font.bold: true
            color: "white"
            Layout.topMargin: 10
        }

        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 300
            color: "#1a1a1a"
            radius: 10
            border.color: "#333333"
            border.width: 2

            ListView {
                id: userListView
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10
                clip: true

                model: userDataManager.availableUsers

                delegate: Rectangle {
                    width: userListView.width - 20
                    height: 80
                    color: mouseArea.containsMouse ? "#2a2a2a" : "#1f1f1f"
                    radius: 8
                    border.color: "#444444"
                    border.width: 1

                    property var userData: modelData

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
                        anchors.margins: 10
                        spacing: 15

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5

                            Text {
                                text: userData.alias
                                font.pixelSize: 22
                                font.bold: true
                                color: "#7cfc00"
                            }

                            Text {
                                text: "Tests: " + userData.totalTests + " | Score: " + userData.totalScore
                                font.pixelSize: 14
                                color: "#999999"
                            }

                            Text {
                                text: "Last active: " + new Date(userData.lastActive).toLocaleString()
                                font.pixelSize: 12
                                color: "#666666"
                            }
                        }

                        Button {
                            text: "Delete"
                            Layout.preferredWidth: 80
                            Layout.preferredHeight: 35

                            background: Rectangle {
                                color: parent.pressed ? "#cc0000" : "#ff3333"
                                radius: 5
                            }

                            contentItem: Text {
                                text: parent.text
                                font.pixelSize: 14
                                color: "white"
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
                        color: "#666666"
                        radius: 4
                    }
                }
            }

            Text {
                visible: userListView.count === 0
                text: "No users found. Create one above!"
                font.pixelSize: 16
                color: "#666666"
                anchors.centerIn: parent
            }
        }
    }

    // Delete confirmation dialog
    Dialog {
        id: deleteDialog
        title: "Confirm Delete"
        modal: true
        anchors.centerIn: parent
        width: 400

        property string userToDelete: ""

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
                text: "Confirm Delete"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }
        }

        contentItem: Text {
            text: "Are you sure you want to delete user '" + deleteDialog.userToDelete + "'?\nThis action cannot be undone."
            font.pixelSize: 16
            color: "white"
            wrapMode: Text.WordWrap
        }

        standardButtons: Dialog.Yes | Dialog.No

        onAccepted: {
            userDataManager.deleteUser(deleteDialog.userToDelete)
            userDataManager.refreshUserList()
        }
    }
}
