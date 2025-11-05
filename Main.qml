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

    // Global shortcut handlers
    function toggleWindow() {
        if (mainWindow.visible) {
            mainWindow.hide()
        } else {
            mainWindow.show()
            mainWindow.raise()
            mainWindow.requestActivate()
        }
    }

    function showLookup() {
        // Show window if hidden
        if (!mainWindow.visible) {
            mainWindow.show()
            mainWindow.raise()
            mainWindow.requestActivate()
        }

        // Navigate to lookup view
        // Check if we're already in the app view with stackView available
        if (stackView.depth > 0) {
            // Try to find AppsView in the stack
            var foundAppsView = false
            for (var i = 0; i < stackView.depth; i++) {
                var item = stackView.get(i)
                if (item && item.toString().indexOf("AppsView") !== -1) {
                    foundAppsView = true
                    break
                }
            }

            // Push LookupView if we can access stackView
            stackView.push("utils/LookupView.qml", {
                stackView: stackView
            })
        }
    }

    StackView {
           id: stackView
           anchors.fill: parent
           initialItem: UserManager {
               appsdata: Fn.appsdata
               stackView: stackView
           }
       }
}


