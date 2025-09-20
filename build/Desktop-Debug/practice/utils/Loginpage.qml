import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle{

    id: tool
    anchors.fill: parent
    color: "black"

    required property StackView stackView

    Rectangle{

        anchors.centerIn: parent
        color: "#282424"
        border.color: "white"
        border.width: 1
        radius: 20
        width: parent.width/3
        height: parent.height/2

        Column {
            spacing: 10
            anchors.centerIn: parent

                TextField {
                    id: nameField
                    placeholderText: "Username"
                    width: 100
                }
                TextField {
                    id: emailField
                    placeholderText: "Email"
                    width: 100
                }
                TextField {
                    id: passwordField
                    placeholderText: "Password"
                    width: 100
                }
         }
    }
}


