import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "utils"
import "keydata.js" as Fn

ApplicationWindow {
    id: mainWindow
    width: 400
    height: 600
    visible: true
    title: "VS Code Shortcuts"

    StackView {
           id: stackView
           anchors.fill: parent
           initialItem: AppsView {
               appsdata: Fn.appsdata
               stackView: stackView
           }
       }
}


